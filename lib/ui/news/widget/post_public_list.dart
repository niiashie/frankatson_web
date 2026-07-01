import 'package:flutter/material.dart';
import 'package:frankoweb/constants/api.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/models/news.dart';
import 'package:frankoweb/ui/news/widget/post_detail_screen.dart';

class PostPublicList extends StatelessWidget {
  final bool isLoading;
  final List<Post> posts;
  final bool isWide;

  const PostPublicList({
    super.key,
    required this.isLoading,
    required this.posts,
    required this.isWide,
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
          const Text(
            "Latest Posts",
            style: TextStyle(
              color: AppColors.gradient2,
              fontFamily: AppFonts.poppinsBold,
              fontSize: 26,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 50,
            height: 3,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [AppColors.gradient1, AppColors.gradient2]),
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
          ),
          const SizedBox(height: 36),
          isLoading
              ? const SizedBox(
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
              : posts.isEmpty
                  ? const SizedBox(
                      height: 200,
                      child: Center(
                        child: Text("No posts yet.",
                            style: TextStyle(color: Colors.grey, fontSize: 15)),
                      ),
                    )
                  : Center(
                      child: Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        alignment: WrapAlignment.center,
                        children: posts
                            .map((p) => _PostCard(post: p, isWide: isWide))
                            .toList(),
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
  const _PostCard({required this.post, required this.isWide});

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
          MaterialPageRoute(
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
              final url = "${Api.dataUrl}${widget.post.image}";
              debugPrint("PostCard image URL: $url");
              return ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.network(
                  url,
                  width: cardWidth,
                  height: 180,
                  fit: BoxFit.cover,
                  loadingBuilder: (_, child, progress) => progress == null
                      ? child
                      : Container(
                          height: 180,
                          color: Colors.grey[100],
                          child: const Center(
                            child: CircularProgressIndicator(
                                color: AppColors.gradient1, strokeWidth: 1),
                          ),
                        ),
                  errorBuilder: (_, error, __) => Container(
                    height: 180,
                    color: Colors.grey[100],
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.broken_image_outlined,
                            color: Colors.grey, size: 32),
                        const SizedBox(height: 8),
                        Text(
                          url,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
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
                            color: AppColors.gradient2.withValues(alpha: 0.55),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${widget.post.likesCount}",
                            style: TextStyle(
                              color: AppColors.gradient2.withValues(alpha: 0.7),
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
