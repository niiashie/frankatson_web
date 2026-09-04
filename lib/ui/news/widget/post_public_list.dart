import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/models/news.dart';
import 'package:frankoweb/ui/news/widget/post_cover.dart';
import 'package:frankoweb/ui/news/widget/post_detail_screen.dart';
import 'package:frankoweb/ui/shared/animations/animations.dart';

class PostPublicList extends StatelessWidget {
  final bool isLoading;
  final List<Map<String, dynamic>> postsList;
  final bool isWide;
  final bool isAdmin;
  final void Function(int index)? onDeletePost;
  final VoidCallback? onReload;

  const PostPublicList({
    super.key,
    required this.isLoading,
    required this.postsList,
    required this.isWide,
    this.isAdmin = false,
    this.onDeletePost,
    this.onReload,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF8F8F8),
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: isWide ? 60 : 44,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Reveal(
            effect: RevealEffect.slideRight,
            child: Text(
              "Latest Posts",
              style: TextStyle(
                color: AppColors.gradient2,
                fontFamily: AppFonts.poppinsBold,
                fontSize: 26,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Reveal(
            effect: RevealEffect.zoomIn,
            scale: 0.1,
            delay: const Duration(milliseconds: 120),
            child: Container(
              width: 50,
              height: 3,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.gradient1, AppColors.gradient2]),
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
            ),
          ),
          const SizedBox(height: 36),
          // Cross-fade between the spinner, the empty state and the results
          // so the list does not snap into place when a request lands.
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: isLoading
                ? const SizedBox(
                    key: ValueKey('loading'),
                    height: 300,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                              color: AppColors.gradient2, strokeWidth: 2),
                          SizedBox(height: 16),
                          Text("Loading posts...",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  )
                : postsList.isEmpty
                    ? SizedBox(
                        key: const ValueKey('empty'),
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("No posts yet.",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15)),
                              if (onReload != null) ...[
                                const SizedBox(height: 16),
                                OutlinedButton.icon(
                                  onPressed: onReload,
                                  icon: const Icon(Icons.refresh, size: 18),
                                  label: const Text("Reload"),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: AppColors.gradient2,
                                    side: const BorderSide(
                                        color: AppColors.gradient2),
                                    shape: const StadiumBorder(),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      )
                    : Center(
                        key: const ValueKey('posts'),
                        child: Wrap(
                          spacing: 24,
                          runSpacing: 24,
                          alignment: WrapAlignment.center,
                          children: postsList.asMap().entries.map((entry) {
                            final index = entry.key;
                            final data = entry.value;
                            return Reveal.staggered(
                              index: index,
                              effect: RevealEffect.zoomIn,
                              step: const Duration(milliseconds: 80),
                              child: _PostCard(
                                post: data['post'] as Post,
                                isWide: isWide,
                                isAdmin: isAdmin,
                                isDeleting: data['loading'] == true,
                                onDelete: onDeletePost != null
                                    ? () => onDeletePost!(index)
                                    : null,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}

class _PostCard extends StatefulWidget {
  final Post post;
  final bool isWide;
  final bool isAdmin;
  final bool isDeleting;
  final VoidCallback? onDelete;

  const _PostCard({
    required this.post,
    required this.isWide,
    this.isAdmin = false,
    this.isDeleting = false,
    this.onDelete,
  });

  @override
  State<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<_PostCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cardWidth = widget.isWide ? 300.0 : double.infinity;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          FadePageRoute(
            builder: (_) => PostDetailScreen(post: widget.post),
          ),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: cardWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? AppColors.gradient2.withValues(alpha: 0.16)
                    : Colors.grey.withValues(alpha: 0.1),
                blurRadius: _hovered ? 24 : 12,
                spreadRadius: _hovered ? 2 : 1,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Builder(builder: (context) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: PostCover(
                        imagePath: widget.post.image,
                        width: cardWidth,
                        height: 180,
                        fit: BoxFit.cover,
                        playButtonSize: 48,
                      ),
                    ),
                    if (widget.isAdmin)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: widget.isDeleting
                            ? Container(
                                width: 30,
                                height: 30,
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                    color: AppColors.gradient2),
                              )
                            : InkWell(
                                onTap: widget.onDelete,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    shape: BoxShape.circle,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black26, blurRadius: 4)
                                    ],
                                  ),
                                  child: const Icon(Icons.delete_outline,
                                      color: Colors.red, size: 16),
                                ),
                              ),
                      ),
                  ],
                );
              }),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        color: _hovered ? AppColors.gradient2 : Colors.black87,
                        fontFamily: AppFonts.poppinsMedium,
                        fontSize: 15,
                        height: 1.4,
                      ),
                      child: Text(widget.post.title ?? ""),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.post.description ?? "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 14),
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
                        Expanded(
                          child: Text(
                            widget.post.user?.name ?? "Frankatson",
                            style: const TextStyle(
                              color: AppColors.gradient2,
                              fontFamily: AppFonts.poppinsMedium,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.favorite,
                              size: 13,
                              color:
                                  AppColors.gradient2.withValues(alpha: 0.55),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${widget.post.likesCount}",
                              style: TextStyle(
                                color:
                                    AppColors.gradient2.withValues(alpha: 0.7),
                                fontFamily: AppFonts.poppinsMedium,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              Icons.chat_bubble_outline,
                              size: 13,
                              color: Colors.grey.withValues(alpha: 0.6),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${widget.post.commentsCount}",
                              style: TextStyle(
                                color: Colors.grey.withValues(alpha: 0.7),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
