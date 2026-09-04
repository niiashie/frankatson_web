import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frankoweb/ui/account/widget/auth_dialog.dart';
import 'package:frankoweb/api/news_api.dart';
import 'package:frankoweb/app/locator.dart';
import 'package:frankoweb/constants/api.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:frankoweb/models/news.dart';
import 'package:frankoweb/services/app.service.dart';
import 'package:frankoweb/ui/news/widget/cover_video_preview.dart';
import 'package:frankoweb/ui/shared/animations/animations.dart';
import 'package:frankoweb/ui/news/widget/post_cover.dart';
import 'package:frankoweb/utils/video_thumbnail.dart';
import 'package:intl/intl.dart';

class PostDetailScreen extends StatefulWidget {
  final Post post;
  const PostDetailScreen({super.key, required this.post});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final _scrollController = ScrollController();
  final _commentController = TextEditingController();
  final _api = PostsApi();
  final _appService = locator<AppService>();

  bool _isScrolled = false;
  bool _liked = false;
  bool _liking = false;
  int _likesCount = 0;
  bool _loadingComments = false;
  bool _loadingMoreComments = false;
  bool _submittingComment = false;
  List<Comment> _comments = [];
  int _totalComments = 0;
  int _currentPage = 1;
  bool _hasMorePages = false;
  String _currentUserId = '';
  bool _playCoverVideo = false;
  bool _videoReady = false;
  Offset? _heroPointerDownPos;

  bool get _isVideoCover => isVideoUrl(widget.post.image);
  String get _coverUrl => "${Api.dataUrl}${widget.post.image}";

  void _startCoverVideo() {
    debugPrint(
        '[PostDetail] _startCoverVideo() — playing cover video: $_coverUrl');
    setState(() {
      _playCoverVideo = true;
      _videoReady = false;
    });
    // Safety net: if the video never signals "ready" (404 / blocked), reveal
    // the element anyway so the browser's own error/controls are visible
    // instead of an endless spinner.
    Future.delayed(const Duration(seconds: 20), () {
      if (mounted && _playCoverVideo && !_videoReady) {
        debugPrint(
            '[PostDetail] cover video ready-timeout — revealing element');
        setState(() => _videoReady = true);
      }
    });
  }

  void _stopCoverVideo() {
    debugPrint('[PostDetail] _stopCoverVideo()');
    setState(() {
      _playCoverVideo = false;
      _videoReady = false;
    });
  }

  void _onCoverVideoReady() {
    debugPrint('[PostDetail] _onCoverVideoReady()');
    if (!mounted || _videoReady) return;
    setState(() => _videoReady = true);
  }

  @override
  void initState() {
    debugPrint("Is it a video cover  : $_isVideoCover");
    super.initState();
    _likesCount = widget.post.likesCount;
    _scrollController.addListener(() {
      final scrolled = _scrollController.offset > 80;
      if (scrolled != _isScrolled) setState(() => _isScrolled = scrolled);

      final pos = _scrollController.position;
      if (pos.pixels >= pos.maxScrollExtent - 250 &&
          _hasMorePages &&
          !_loadingMoreComments &&
          !_loadingComments) {
        _loadComments(page: _currentPage + 1);
      }
    });
    _init();
  }

  Future<void> _init() async {
    // if (_isVideoCover) {
    //   _startCoverVideo();
    // }
    final user = await _appService.getUser();
    if (user.isNotEmpty) _currentUserId = user['id'] ?? '';
    _loadComments();
  }

  Future<void> _loadComments({int page = 1}) async {
    debugPrint("Load comments called");
    if (page == 1) {
      setState(() => _loadingComments = true);
    } else {
      setState(() => _loadingMoreComments = true);
    }
    try {
      final res = await _api.getPostComments(
        widget.post.id.toString(),
        page: page,
      );
      if (res.ok) {
        final envelope = res.body as Map<String, dynamic>;

        final paginated = envelope['comments'] as Map<String, dynamic>;
        final items = (paginated['data'] as List<dynamic>)
            .map((e) => Comment.fromJson(e))
            .toList();
        setState(() {
          if (page == 1) {
            _comments = items;
          } else {
            _comments = [..._comments, ...items];
          }
          _currentPage = paginated['current_page'] ?? 1;
          _hasMorePages = paginated['next_page_url'] != null;
          _totalComments = envelope['comments_count'] ?? _comments.length;
        });
      }
    } on DioException catch (_) {
    } finally {
      setState(() {
        _loadingComments = false;
        _loadingMoreComments = false;
      });
    }
  }

  Future<void> _toggleLike() async {
    if (_liking || _currentUserId.isEmpty) return;
    setState(() => _liking = true);
    try {
      // The server takes the actor from the bearer token; sending an id here
      // would be ignored, and trusting one would be forgeable.
      final res = await _api.likePost(widget.post.id.toString(), null);
      if (res.ok) {
        setState(() {
          _liked = !_liked;
          _likesCount += _liked ? 1 : -1;
        });
      }
    } on DioException catch (_) {
    } finally {
      setState(() => _liking = false);
    }
  }

  Future<void> _submitComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty || _submittingComment || _currentUserId.isEmpty) return;
    setState(() => _submittingComment = true);
    try {
      final res = await _api.addComment(
        widget.post.id.toString(),
        {'body': text},
      );
      if (res.ok) {
        _commentController.clear();
        _loadComments(page: 1);
      }
    } on DioException catch (_) {
    } finally {
      setState(() => _submittingComment = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 800;
    final hasImage = widget.post.image != null && widget.post.image!.isNotEmpty;

    final playingVideo = _isVideoCover && _playCoverVideo;

    return Scaffold(
      backgroundColor: playingVideo ? Colors.black : Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            physics: playingVideo ? const NeverScrollableScrollPhysics() : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                hasImage ? _buildImageHero(isWide) : _buildGradientHero(isWide),
                // Everything below the hero is hidden while the video plays.
                if (!playingVideo) ...[
                  Reveal(child: _buildContent(isWide)),
                  Reveal(
                    effect: RevealEffect.fade,
                    child: _buildEngagement(isWide),
                  ),
                  Reveal(
                    delay: const Duration(milliseconds: 100),
                    child: _buildComments(isWide),
                  ),
                  const SizedBox(height: 60),
                ],
              ],
            ),
          ),
          if (!playingVideo) _buildHeader(context, isWide),
        ],
      ),
    );
  }

  double _heroHeight(bool isWide) {
    if (_isVideoCover && _playCoverVideo) return isWide ? 640 : 360;
    if (_isVideoCover) return isWide ? 520 : 320;
    return isWide ? 460 : 280;
  }

  Widget _buildHeader(BuildContext context, bool isWide) {
    final fgColor = _isScrolled ? AppColors.gradient2 : Colors.white;
    final fgMuted =
        _isScrolled ? AppColors.gradient2.withValues(alpha: 0.6) : Colors.white;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: _isScrolled ? Colors.white : Colors.transparent,
        boxShadow: _isScrolled
            ? [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.18),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                )
              ]
            : [],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  elevation: _isScrolled ? 2 : 5,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    width: isWide ? 50 : 36,
                    height: isWide ? 50 : 36,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(AppImages.logo,
                          width: isWide ? 50 : 36, height: isWide ? 50 : 36),
                    ),
                  ),
                ),
                if (isWide) ...[
                  const SizedBox(width: 10),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      color: fgColor,
                      fontFamily: AppFonts.poppinsMedium,
                      fontSize: 25,
                    ),
                    child: const Text("Frankatson"),
                  ),
                ],
              ],
            ),
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      color: fgMuted,
                      fontFamily: AppFonts.poppinsLight,
                      fontSize: isWide ? 16 : 13,
                    ),
                    child: const Text("Posts"),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.chevron_right, size: 16, color: fgMuted),
                const SizedBox(width: 8),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: TextStyle(
                    color: fgColor,
                    fontFamily: AppFonts.poppinsBold,
                    fontSize: isWide ? 18 : 14,
                  ),
                  child: Text(
                    widget.post.title ?? "Post",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageHero(bool isWide) {
    if (_isVideoCover && _playCoverVideo) {
      return SizedBox(
        width: double.infinity,
        height: _heroHeight(isWide),
        child: _buildInlineVideo(isWide),
      );
    }

    final heroStack = Stack(
      fit: StackFit.expand,
      children: [
        if (_isVideoCover)
          PostCover(
            imagePath: widget.post.image,
            fit: BoxFit.contain,
            playButtonSize: isWide ? 74 : 58,
          )
        else
          Image.network(
            "${Api.dataUrl}${widget.post.image}",
            fit: BoxFit.contain,
            loadingBuilder: (_, child, progress) =>
                progress == null ? child : Container(color: Colors.grey[200]),
            errorBuilder: (_, __, ___) =>
                Container(color: const Color(0xFFEEEEEE)),
          ),
        // Scrim — ignore pointers so it can't swallow taps.
        const IgnorePointer(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black87],
                stops: [0.4, 1.0],
              ),
            ),
          ),
        ),
        Positioned(
          left: isWide ? 80 : 24,
          right: isWide ? 80 : 24,
          bottom: 36,
          child: IgnorePointer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.post.title ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: AppFonts.poppinsBold,
                    fontSize: isWide ? 36 : 22,
                    height: 1.3,
                    shadows: const [
                      Shadow(
                          color: Colors.black38,
                          blurRadius: 8,
                          offset: Offset(0, 2))
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                _buildMeta(onDark: true),
              ],
            ),
          ),
        ),
      ],
    );

    if (!_isVideoCover) {
      return SizedBox(
        width: double.infinity,
        height: _heroHeight(isWide),
        child: heroStack,
      );
    }

    // Drive the tap straight off raw pointer events — this fires during event
    // dispatch, independent of the gesture arena, so a parent scroll view or a
    // nested Stack/Center can't "lose" it.
    return SizedBox(
      width: double.infinity,
      height: _heroHeight(isWide),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Listener(
          behavior: HitTestBehavior.opaque,
          onPointerDown: (e) {
            _heroPointerDownPos = e.position;
            debugPrint('[PostDetail] hero pointer DOWN @ ${e.localPosition}');
          },
          onPointerUp: (e) {
            final start = _heroPointerDownPos;
            _heroPointerDownPos = null;
            debugPrint('[PostDetail] hero pointer UP (start=$start)');
            if (start == null) return;
            if ((e.position - start).distance > 12) return; // scroll / drag
            if (_playCoverVideo) return;
            debugPrint('[PostDetail] hero tap -> starting video');
            _startCoverVideo();
          },
          child: heroStack,
        ),
      ),
    );
  }

  Widget _buildInlineVideo(bool isWide) {
    return Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 44,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: InkWell(
                  onTap: _stopCoverVideo,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.close, color: Colors.white, size: 18),
                      SizedBox(width: 6),
                      Text("Close video",
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Always mounted so it actually loads + autoplays. The loading
                // circle sits on top until the video signals it can play.
                CoverVideoPreview(
                  src: _coverUrl,
                  height: null,
                  autoPlay: true,
                  onReady: _onCoverVideoReady,
                ),
                if (!_videoReady)
                  Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: _videoLoadingCircle(isWide ? 74 : 58),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _videoLoadingCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black38, blurRadius: 12, spreadRadius: 1),
        ],
      ),
      alignment: Alignment.center,
      child: SizedBox(
        width: size * 0.5,
        height: size * 0.5,
        child: const CircularProgressIndicator(
            color: Colors.white, strokeWidth: 2.5),
      ),
    );
  }

  Widget _buildGradientHero(bool isWide) {
    return SizedBox(
      width: double.infinity,
      height: isWide ? 380 : 280,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFFFFC8E4),
                  AppColors.gradient2,
                  AppColors.gradient1,
                ],
                stops: [0.0, 0.45, 1.0],
              ),
            ),
          ),
          Positioned(
            right: isWide ? -20 : -50,
            bottom: -20,
            child: Opacity(
              opacity: 0.1,
              child: Icon(Icons.article_outlined,
                  color: Colors.white, size: isWide ? 320 : 220),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                isWide ? 80 : 24, 100, isWide ? 80 : 24, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.post.title ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: AppFonts.poppinsBold,
                    fontSize: isWide ? 36 : 22,
                    height: 1.3,
                    shadows: const [
                      Shadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 3))
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _buildMeta(onDark: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeta({required bool onDark}) {
    final color = onDark ? Colors.white70 : Colors.grey;
    final date = widget.post.date != null
        ? DateFormat.yMMMd().format(widget.post.date!)
        : '';
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.person_outline, size: 14, color: color),
        const SizedBox(width: 5),
        Text(
          widget.post.user?.name ?? "Frankatson",
          style: TextStyle(
              color: color, fontFamily: AppFonts.poppinsMedium, fontSize: 13),
        ),
        if (date.isNotEmpty) ...[
          const SizedBox(width: 16),
          Icon(Icons.calendar_today_outlined, size: 13, color: color),
          const SizedBox(width: 5),
          Text(date, style: TextStyle(color: color, fontSize: 13)),
        ],
      ],
    );
  }

  Widget _buildContent(bool isWide) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
          horizontal: isWide ? 80 : 24, vertical: isWide ? 52 : 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.post.image != null && widget.post.image!.isNotEmpty) ...[
            _buildMeta(onDark: false),
            const SizedBox(height: 28),
          ],
          if (widget.post.description != null) ...[
            Text(
              widget.post.description!,
              style: const TextStyle(
                color: AppColors.gradient2,
                fontFamily: AppFonts.poppinsMedium,
                fontSize: 17,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 50,
              height: 3,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.gradient1, AppColors.gradient2]),
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
            ),
            const SizedBox(height: 28),
          ],
          if (widget.post.content != null)
            Text(
              widget.post.content!,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 15,
                height: 1.9,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEngagement(bool isWide) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF8F8F8),
      padding: EdgeInsets.symmetric(horizontal: isWide ? 80 : 24, vertical: 24),
      child: Row(
        children: [
          if (_currentUserId.isNotEmpty) ...[
            _LikeButton(
              liked: _liked,
              liking: _liking,
              count: _likesCount,
              onTap: _toggleLike,
            ),
            const SizedBox(width: 24),
          ],
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.chat_bubble_outline,
                  size: 20, color: AppColors.gradient2.withValues(alpha: 0.6)),
              const SizedBox(width: 6),
              Text(
                "$_totalComments",
                style: TextStyle(
                  color: AppColors.gradient2.withValues(alpha: 0.8),
                  fontFamily: AppFonts.poppinsMedium,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 4),
              Text("comments",
                  style: TextStyle(color: Colors.grey[500], fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComments(bool isWide) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
          horizontal: isWide ? 80 : 24, vertical: isWide ? 48 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Comments",
            style: TextStyle(
              color: AppColors.gradient2,
              fontFamily: AppFonts.poppinsBold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 3,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [AppColors.gradient1, AppColors.gradient2]),
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
          ),
          const SizedBox(height: 24),
          _currentUserId.isNotEmpty
              ? _buildCommentForm(isWide)
              : _buildLoginPrompt(),
          const SizedBox(height: 28),
          _loadingComments
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: CircularProgressIndicator(
                        color: AppColors.gradient2, strokeWidth: 2),
                  ),
                )
              : _comments.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Text(
                        "No comments yet. Be the first to share your thoughts.",
                        style: TextStyle(color: Colors.grey[400], fontSize: 14),
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _comments.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (_, i) =>
                              _CommentTile(comment: _comments[i]),
                        ),
                        if (_loadingMoreComments)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.gradient2, strokeWidth: 2),
                            ),
                          ),
                      ],
                    ),
        ],
      ),
    );
  }

  Widget _buildCommentForm(bool isWide) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: TextField(
            controller: _commentController,
            maxLines: 3,
            minLines: 1,
            decoration: InputDecoration(
              hintText: "Write a comment...",
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
              filled: true,
              fillColor: const Color(0xFFF8F8F8),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide:
                    BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide:
                    BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: AppColors.gradient2, width: 1.5),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        InkWell(
          onTap: _submittingComment ? null : _submitComment,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.gradient1, AppColors.gradient2],
              ),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Center(
              child: _submittingComment
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2),
                    )
                  : const Icon(Icons.send_rounded,
                      color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginPrompt() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          const Icon(Icons.chat_bubble_outline,
              size: 20, color: AppColors.gradient2),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Login to leave a comment",
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ),
          InkWell(
            onTap: () async {
              if (await showAuthDialog(context) == true && mounted) _init();
            },
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.gradient1, AppColors.gradient2]),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: const Text(
                "Login",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: AppFonts.poppinsMedium,
                    fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LikeButton extends StatelessWidget {
  final bool liked;
  final bool liking;
  final int count;
  final VoidCallback? onTap;

  const _LikeButton({
    required this.liked,
    required this.liking,
    required this.count,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: liked
              ? AppColors.gradient2.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: liked
                ? AppColors.gradient2.withValues(alpha: 0.5)
                : Colors.grey.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            liking
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                        color: AppColors.gradient2, strokeWidth: 1.5),
                  )
                : Icon(
                    liked ? Icons.favorite : Icons.favorite_border,
                    size: 18,
                    color: liked ? AppColors.gradient2 : Colors.grey,
                  ),
            const SizedBox(width: 6),
            Text(
              "$count",
              style: TextStyle(
                color: liked ? AppColors.gradient2 : Colors.grey,
                fontFamily: AppFonts.poppinsMedium,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 4),
            Text("likes",
                style: TextStyle(color: Colors.grey[500], fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  final Comment comment;
  const _CommentTile({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [AppColors.gradient1, AppColors.gradient2]),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: AppColors.gradient2.withValues(alpha: 0.2),
                    blurRadius: 6)
              ],
            ),
            child: Center(
              child: Text(
                (comment.user?.name ?? "?")[0].toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: AppFonts.poppinsBold,
                    fontSize: 14),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.user?.name ?? "Anonymous",
                      style: const TextStyle(
                          fontFamily: AppFonts.poppinsMedium,
                          fontSize: 13,
                          color: Colors.black87),
                    ),
                    if (comment.createdAt != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        DateFormat.yMMMd().format(comment.createdAt!),
                        style: TextStyle(fontSize: 11, color: Colors.grey[400]),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  comment.body ?? "",
                  style: const TextStyle(
                      color: Colors.black87, fontSize: 14, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
