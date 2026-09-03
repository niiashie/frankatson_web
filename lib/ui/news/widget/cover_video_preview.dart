import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';

/// Inline, playable `<video controls>` element (web only), rendered through an
/// [HtmlElementView].
///
/// Used both for the local cover preview on the create-post form (a `blob:`
/// URL) and for playing a published post's video cover on the detail screen
/// (a remote URL). When [autoPlay] is set it starts playing as soon as it is
/// mounted — e.g. right after the user taps the poster's play button.
class CoverVideoPreview extends StatefulWidget {
  /// Video source — a `blob:` object URL (local preview) or a remote URL.
  final String src;

  /// Fixed height. Pass `null` to let the parent constrain it (e.g. inside an
  /// [Expanded]).
  final double? height;

  /// Start playback immediately on mount.
  final bool autoPlay;

  /// Fired once the video has buffered enough to start playing.
  final VoidCallback? onReady;

  const CoverVideoPreview({
    super.key,
    required this.src,
    this.height = 190,
    this.autoPlay = false,
    this.onReady,
  });

  @override
  State<CoverVideoPreview> createState() => _CoverVideoPreviewState();
}

class _CoverVideoPreviewState extends State<CoverVideoPreview> {
  late final String _viewType;
  html.VideoElement? _video;

  @override
  void initState() {
    super.initState();
    // Unique per instance so re-mounting registers a fresh factory.
    _viewType =
        'cover-video-${identityHashCode(this)}-${DateTime.now().microsecondsSinceEpoch}';
    debugPrint('[CoverVideoPreview] init — src=${widget.src} autoPlay=${widget.autoPlay}');
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int _) {
      debugPrint('[CoverVideoPreview] creating <video> element for ${widget.src}');
      final video = html.VideoElement()
        ..src = widget.src
        ..controls = true
        ..autoplay = widget.autoPlay
        ..preload = widget.autoPlay ? 'auto' : 'metadata'
        ..setAttribute('playsinline', 'true')
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.objectFit = 'contain'
        ..style.backgroundColor = 'black'
        ..style.border = 'none';
      _video = video;

      var notified = false;
      void notify(String from) {
        if (notified) return;
        notified = true;
        debugPrint('[CoverVideoPreview] ready ($from) — ${widget.src}');
        widget.onReady?.call();
      }

      video.onCanPlay.listen((_) => notify('canplay'));
      video.onPlaying.listen((_) => notify('playing'));
      video.onLoadedData.listen((_) => notify('loadeddata'));
      video.onError.listen((_) => debugPrint(
          '[CoverVideoPreview] <video> error for ${widget.src}: ${video.error?.code}'));

      if (widget.autoPlay) {
        // The state change was triggered by a user tap, so most browsers allow
        // playback with sound. Fall back to muted autoplay if the browser
        // still blocks it; the native controls remain available regardless.
        video.play().catchError((Object e) {
          debugPrint('[CoverVideoPreview] play() rejected ($e) — retrying muted');
          video.muted = true;
          video.play();
        });
      }
      return video;
    });
  }

  @override
  void dispose() {
    // Stop playback and release the media element.
    _video?.pause();
    _video?.removeAttribute('src');
    _video?.load();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final view = HtmlElementView(viewType: _viewType);
    if (widget.height == null) return view;
    return SizedBox(
      width: double.infinity,
      height: widget.height,
      child: view,
    );
  }
}
