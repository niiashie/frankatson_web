import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

/// File extensions we treat as video cover media.
const Set<String> _videoExtensions = {
  'mp4', 'm4v', 'mov', 'webm', 'mkv', 'avi', '3gp', 'mpeg', 'mpg', 'ogv',
};

/// Whether [url] (a full URL or a stored relative path) points at a video.
bool isVideoUrl(String? url) {
  if (url == null || url.isEmpty) return false;
  final clean = url.split('?').first.split('#').first;
  final dot = clean.lastIndexOf('.');
  if (dot == -1) return false;
  return _videoExtensions.contains(clean.substring(dot + 1).toLowerCase());
}

/// Cache keyed by URL so a thumbnail is only ever decoded once per session and
/// concurrent callers share the same in-flight future.
final Map<String, Future<Uint8List?>> _thumbCache = {};

/// Grabs a single frame from [url] and returns it as JPEG bytes, or `null` if
/// the frame can't be captured (network error, unsupported codec, or — most
/// commonly — the video host doesn't send CORS headers so the canvas is
/// tainted). Callers should fall back to a generic video poster on `null`.
Future<Uint8List?> generateVideoThumbnail(
  String url, {
  double captureAtSeconds = 0.5,
  int maxWidth = 640,
}) {
  return _thumbCache.putIfAbsent(
    url,
    () => _capture(url, captureAtSeconds, maxWidth),
  );
}

Future<Uint8List?> _capture(String url, double atSeconds, int maxWidth) {
  final completer = Completer<Uint8List?>();

  final video = html.VideoElement()
    ..src = url
    ..crossOrigin = 'anonymous'
    ..muted = true
    ..preload = 'auto'
    ..setAttribute('playsinline', 'true');
  video.style
    ..position = 'fixed'
    ..left = '-10000px'
    ..top = '0'
    ..width = '1px'
    ..height = '1px'
    ..opacity = '0';
  html.document.body?.append(video);

  StreamSubscription<html.Event>? loadedSub;
  StreamSubscription<html.Event>? seekedSub;
  StreamSubscription<html.Event>? errorSub;
  Timer? timeout;

  void cleanup() {
    loadedSub?.cancel();
    seekedSub?.cancel();
    errorSub?.cancel();
    timeout?.cancel();
    video.removeAttribute('src');
    video.load();
    video.remove();
  }

  void finish(Uint8List? bytes) {
    if (!completer.isCompleted) completer.complete(bytes);
    cleanup();
  }

  errorSub = video.onError.listen((_) => finish(null));
  timeout = Timer(const Duration(seconds: 12), () => finish(null));

  loadedSub = video.onLoadedMetadata.listen((_) {
    final duration = video.duration;
    var target = atSeconds;
    if (duration.isFinite && duration > 0 && duration <= atSeconds) {
      target = duration / 2;
    }
    try {
      video.currentTime = target;
    } catch (_) {
      finish(null);
    }
  });

  seekedSub = video.onSeeked.listen((_) {
    try {
      final vw = video.videoWidth;
      final vh = video.videoHeight;
      if (vw == 0 || vh == 0) {
        finish(null);
        return;
      }
      final scale = vw > maxWidth ? maxWidth / vw : 1.0;
      final cw = (vw * scale).round();
      final ch = (vh * scale).round();

      final canvas = html.CanvasElement(width: cw, height: ch);
      canvas.context2D
          .drawImageScaled(video, 0, 0, cw.toDouble(), ch.toDouble());

      final dataUrl = canvas.toDataUrl('image/jpeg', 0.82);
      final comma = dataUrl.indexOf(',');
      if (comma == -1) {
        finish(null);
        return;
      }
      finish(base64Decode(dataUrl.substring(comma + 1)));
    } catch (_) {
      // Usually a SecurityError: the video is cross-origin without CORS.
      finish(null);
    }
  });

  return completer.future;
}
