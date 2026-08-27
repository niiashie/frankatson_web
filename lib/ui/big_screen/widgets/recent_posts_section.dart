import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:frankoweb/constants/api.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/models/news.dart';
import 'package:intl/intl.dart';

/// A "Latest News" teaser carousel for the landing page.
///
/// Shows up to the 5 most recent posts, each as a photo (left) + title,
/// description and author/date (right) card. The whole section hides itself
/// while loading and whenever there is nothing to show, so a failed request
/// never leaves a broken widget on the home page.
class RecentPostsSection extends StatelessWidget {
  final Key? sectionKey;
  final List<Post> posts;
  final bool isLoading;
  final VoidCallback onViewAll;
  final void Function(Post post) onPostTap;

  const RecentPostsSection({
    super.key,
    this.sectionKey,
    required this.posts,
    required this.isLoading,
    required this.onViewAll,
    required this.onPostTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading || posts.isEmpty) return const SizedBox.shrink();

    final isWide = MediaQuery.of(context).size.width >= 800;
    final items = posts.take(5).toList();

    return Container(
      key: sectionKey,
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: isWide ? 60 : 44),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Latest News",
            style: TextStyle(
              color: AppColors.gradient2,
              fontSize: 30,
              fontFamily: AppFonts.poppinsBold,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: 50,
            height: 2,
            decoration: const BoxDecoration(
              color: AppColors.gradient1,
              borderRadius: BorderRadius.all(Radius.circular(1)),
            ),
          ),
          const SizedBox(height: 30),
          CarouselSlider(
            options: CarouselOptions(
              height: isWide ? 300 : 430,
              viewportFraction: isWide ? 0.78 : 0.92,
              enlargeCenterPage: isWide,
              autoPlay: items.length > 1,
              autoPlayInterval: const Duration(seconds: 8),
              autoPlayAnimationDuration: const Duration(milliseconds: 600),
              enableInfiniteScroll: items.length > 1,
              pauseAutoPlayOnTouch: true,
            ),
            items: items
                .map((post) => _PostSlide(
                      post: post,
                      isWide: isWide,
                      onTap: () => onPostTap(post),
                    ))
                .toList(),
          ),
          const SizedBox(height: 26),
          Material(
            color: AppColors.gradient2,
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            elevation: 2,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              onTap: onViewAll,
              child: Container(
                width: 150,
                height: 46,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: const Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "View More",
                        style: TextStyle(
                          fontFamily: AppFonts.poppinsMedium,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.chevron_right, size: 15, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PostSlide extends StatefulWidget {
  final Post post;
  final bool isWide;
  final VoidCallback onTap;

  const _PostSlide({
    required this.post,
    required this.isWide,
    required this.onTap,
  });

  @override
  State<_PostSlide> createState() => _PostSlideState();
}

class _PostSlideState extends State<_PostSlide> {
  bool _hovered = false;

  String get _imageUrl => "${Api.dataUrl}${widget.post.image ?? ''}";

  String get _dateLabel => widget.post.date != null
      ? DateFormat.yMMMd().format(widget.post.date!)
      : "";

  String get _author => widget.post.user?.name ?? "Frankatson";

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? AppColors.gradient2.withValues(alpha: 0.16)
                    : Colors.grey.withValues(alpha: 0.12),
                blurRadius: _hovered ? 24 : 14,
                spreadRadius: _hovered ? 2 : 1,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: widget.isWide ? _wideLayout() : _narrowLayout(),
        ),
      ),
    );
  }

  Widget _wideLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
          child: SizedBox(width: 300, child: _image()),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: _details(titleSize: 20, descLines: 3),
          ),
        ),
      ],
    );
  }

  Widget _narrowLayout() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: SizedBox(height: 180, width: double.infinity, child: _image()),
        ),
        Padding(
          padding: const EdgeInsets.all(18),
          child: _details(titleSize: 16, descLines: 2),
        ),
      ],
    );
  }

  Widget _image() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey[100],
      child: Image.network(
        _imageUrl,
        // Show the whole image — no cropping — within the available box.
        fit: BoxFit.fill,
        width: double.infinity,
        height: double.infinity,
        loadingBuilder: (_, child, progress) => progress == null
            ? child
            : const Center(
                child: CircularProgressIndicator(
                    color: AppColors.gradient1, strokeWidth: 1.5),
              ),
        errorBuilder: (_, __, ___) => const Center(
          child: Icon(Icons.image_not_supported_outlined,
              color: Colors.grey, size: 32),
        ),
      ),
    );
  }

  Widget _details({required double titleSize, required int descLines}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.post.title ?? "",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: _hovered ? AppColors.gradient2 : Colors.black87,
            fontFamily: AppFonts.poppinsBold,
            fontSize: titleSize,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          widget.post.description ?? "",
          maxLines: descLines,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.gradient2.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                _author,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.gradient2,
                  fontFamily: AppFonts.poppinsMedium,
                  fontSize: 12,
                ),
              ),
            ),
            if (_dateLabel.isNotEmpty) ...[
              const SizedBox(width: 10),
              Text(
                _dateLabel,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
