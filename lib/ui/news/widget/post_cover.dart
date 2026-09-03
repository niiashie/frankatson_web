import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:frankoweb/constants/api.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/utils/video_thumbnail.dart';

/// Renders a post's cover media.
///
/// * Image cover  -> `Image.network`
/// * Video cover  -> a frame grabbed from the video (see
///   [generateVideoThumbnail]) with a play button hovering over it. If the
///   frame can't be captured (e.g. the video host has no CORS headers) it
///   falls back to a dark poster that still shows the play button.
class PostCover extends StatefulWidget {
  /// Stored path from `Post.image` (relative to [Api.dataUrl]).
  final String? imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;

  /// Corner radius applied here. Pass 0 when the caller already clips.
  final double borderRadius;
  final double playButtonSize;

  /// Called when the play button is tapped (video covers only). When provided,
  /// the button becomes an opaque hit target so the tap always registers.
  final VoidCallback? onPlayTap;

  /// Show a spinner in place of the play icon (e.g. while the video URL loads).
  final bool isLoading;

  const PostCover({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 0,
    this.playButtonSize = 54,
    this.onPlayTap,
    this.isLoading = false,
  });

  @override
  State<PostCover> createState() => _PostCoverState();
}

class _PostCoverState extends State<PostCover> {
  String get _url => "${Api.dataUrl}${widget.imagePath ?? ''}";
  bool get _isVideo => isVideoUrl(widget.imagePath);

  Uint8List? _thumb;
  bool _thumbLoading = false;

  @override
  void initState() {
    super.initState();
    if (_isVideo) _loadThumb();
  }

  @override
  void didUpdateWidget(covariant PostCover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imagePath != widget.imagePath) {
      _thumb = null;
      if (_isVideo) _loadThumb();
    }
  }

  Future<void> _loadThumb() async {
    setState(() => _thumbLoading = true);
    final bytes = await generateVideoThumbnail(_url);
    if (!mounted) return;
    setState(() {
      _thumb = bytes;
      _thumbLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('[PostCover] build — imagePath=${widget.imagePath} '
        'isVideo=$_isVideo hasOnPlayTap=${widget.onPlayTap != null}');
    final content = _isVideo ? _buildVideo() : _buildImage();
    if (widget.borderRadius > 0) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: content,
      );
    }
    return content;
  }

  Widget _buildImage() {
    return Image.network(
      _url,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      loadingBuilder: (_, child, progress) => progress == null
          ? child
          : _placeholder(const CircularProgressIndicator(
              color: AppColors.gradient1, strokeWidth: 1.5)),
      errorBuilder: (_, __, ___) => _placeholder(const Icon(
          Icons.image_not_supported_outlined,
          color: Colors.grey,
          size: 32)),
    );
  }

  Widget _buildVideo() {
    final Widget base = _thumb != null
        ? Image.memory(
            _thumb!,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
          )
        : Container(
            width: widget.width,
            height: widget.height,
            color: const Color(0xFF1C1C1E),
            alignment: Alignment.center,
            child: _thumbLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                        color: Colors.white54, strokeWidth: 2),
                  )
                : null,
          );

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          base,
          if (_thumb != null)
            Container(color: Colors.black.withValues(alpha: 0.14)),
          Center(child: _playButton()),
        ],
      ),
    );
  }

  Widget _playButton() {
    final s = widget.playButtonSize;

    final circle = Container(
      width: s,
      height: s,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black38, blurRadius: 12, spreadRadius: 1),
        ],
      ),
      alignment: Alignment.center,
      child: widget.isLoading
          ? SizedBox(
              width: s * 0.5,
              height: s * 0.5,
              child: const CircularProgressIndicator(
                  color: Colors.white, strokeWidth: 2.5),
            )
          : Icon(Icons.play_arrow_rounded, color: Colors.white, size: s * 0.62),
    );

    // Decorative only when there's no handler (list/carousel cards handle the
    // tap themselves).
    if (widget.onPlayTap == null) return circle;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Listener(
        // Raw diagnostic: fires on the pointer itself, before the gesture
        // arena, so we can tell whether events even reach the button.
        onPointerDown: (_) => debugPrint(
            '[PostCover] pointer DOWN on play button (url=$_url)'),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            debugPrint(
                '[PostCover] play button TAPPED (url=$_url, isLoading=${widget.isLoading})');
            if (!widget.isLoading) widget.onPlayTap!.call();
          },
          child: circle,
        ),
      ),
    );
  }

  Widget _placeholder(Widget child) => Container(
        width: widget.width,
        height: widget.height,
        color: Colors.grey[100],
        alignment: Alignment.center,
        child: child,
      );
}
