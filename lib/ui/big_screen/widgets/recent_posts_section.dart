import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/models/news.dart';
import 'package:frankoweb/ui/news/widget/post_cover.dart';
import 'package:frankoweb/ui/shared/animations/animations.dart';
import 'package:intl/intl.dart';

/// A "Latest News" teaser for the landing page.
///
/// Shows the 3 most recent posts side by side, each as a card with the post
/// cover, title, a short description and the publish date, plus an arrow in
/// the bottom-right that opens the post. The section hides itself while
/// loading and whenever there is nothing to show, so a failed request never
/// leaves a broken widget on the home page.
class RecentPostsSection extends StatelessWidget {
  final Key? sectionKey;
  final List<Post> posts;
  final bool isLoading;
  final VoidCallback onViewAll;
  final void Function(Post post) onPostTap;

  /// Widest the card row is allowed to get, so three cards keep a readable
  /// measure on very wide monitors instead of stretching edge to edge.
  static const double _maxContentWidth = 1200;

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

    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 800;
    final items = posts.take(3).toList();

    // Three across on desktop, two on tablets, stacked on phones.
    final columns = width >= 1000
        ? 3
        : width >= 700
            ? 2
            : 1;

    return Container(
      key: sectionKey,
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: isWide ? 60 : 44),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Reveal(
            effect: RevealEffect.slideDown,
            distance: 24,
            child: Text(
              "Recent Posts",
              style: TextStyle(
                color: AppColors.gradient2,
                fontSize: 30,
                fontFamily: AppFonts.poppinsBold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          const Reveal(
            effect: RevealEffect.zoomIn,
            scale: 0.1,
            delay: Duration(milliseconds: 120),
            child: SizedBox(
              width: 50,
              height: 2,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.gradient1,
                  borderRadius: BorderRadius.all(Radius.circular(1)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 34),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isWide ? 40 : 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _maxContentWidth),
              child: _cardGrid(items, columns),
            ),
          ),
          const SizedBox(height: 34),
        ],
      ),
    );
  }

  /// Lays the cards out in rows of [columns], padding the final row with empty
  /// slots so a leftover card keeps its column width instead of stretching.
  Widget _cardGrid(List<Post> items, int columns) {
    const gap = 24.0;
    final rows = <Widget>[];

    for (var start = 0; start < items.length; start += columns) {
      final slice = items.skip(start).take(columns).toList();
      final children = <Widget>[];

      for (var i = 0; i < columns; i++) {
        if (i > 0) children.add(const SizedBox(width: gap));
        children.add(
          Expanded(
            child: i < slice.length
                ? Reveal(
                    effect: RevealEffect.slideUp,
                    distance: 28,
                    delay: Duration(milliseconds: 160 + (start + i) * 110),
                    child: _PostCard(
                      post: slice[i],
                      onTap: () => onPostTap(slice[i]),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        );
      }

      if (rows.isNotEmpty) rows.add(const SizedBox(height: gap));
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      );
    }

    return Column(mainAxisSize: MainAxisSize.min, children: rows);
  }
}

class _PostCard extends StatefulWidget {
  final Post post;
  final VoidCallback onTap;

  const _PostCard({required this.post, required this.onTap});

  @override
  State<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<_PostCard> {
  bool _hovered = false;

  String get _dateLabel => widget.post.date != null
      ? DateFormat('d MMMM, y').format(widget.post.date!).toUpperCase()
      : "";

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
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? AppColors.gradient2.withValues(alpha: 0.18)
                    : Colors.grey.withValues(alpha: 0.14),
                blurRadius: _hovered ? 22 : 12,
                spreadRadius: _hovered ? 1 : 0,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 10,
                  child: Container(
                    color: Colors.grey[100],
                    child: PostCover(
                      imagePath: widget.post.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      playButtonSize: 44,
                    ),
                  ),
                ),
              ),
              Expanded(child: _details()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _details() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.post.title ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: _hovered ? AppColors.gradient2 : Colors.black87,
              fontFamily: AppFonts.poppinsBold,
              fontSize: 16,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.post.description ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
              height: 1.6,
            ),
          ),
          // Pushes the date/arrow row to the bottom so it lines up across
          // cards of differing text length.
          const Spacer(),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: Text(
                  _dateLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontFamily: AppFonts.poppinsMedium,
                    fontSize: 11,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: widget.onTap,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: AnimatedSlide(
                      duration: const Duration(milliseconds: 200),
                      offset: _hovered ? const Offset(0.18, 0) : Offset.zero,
                      child: Icon(
                        Icons.arrow_right_alt,
                        size: 22,
                        color:
                            _hovered ? AppColors.gradient2 : Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
