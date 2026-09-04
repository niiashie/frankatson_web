import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/ui/news/add_post_view.dart';
import 'package:frankoweb/ui/news/news_view_model.dart';
import 'package:frankoweb/ui/news/widget/post_public_list.dart';
import 'package:frankoweb/ui/shared/animations/animations.dart';
import 'package:frankoweb/ui/news/widget/posts_app_bar.dart';
import 'package:stacked/stacked.dart';
// PostsManageTable is no longer used — admin post management now happens
// inline via delete icons on PostPublicList cards and a dedicated Add Post page.
// import 'package:frankoweb/ui/news/widget/posts_manage_table.dart';

class PostsView extends StackedView<PostsViewModel> {
  const PostsView({Key? key}) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(PostsViewModel viewModel) async {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
      BuildContext context, PostsViewModel viewModel, Widget? child) {
    final isWide = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: viewModel.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHero(isWide),
                PostPublicList(
                  isLoading: viewModel.getPostsLoading,
                  postsList: viewModel.postsList,
                  isWide: isWide,
                  isAdmin: viewModel.isAdmin,
                  onDeletePost: viewModel.deletePost,
                  onReload: viewModel.getPosts,
                ),
                // Manage-posts table replaced by inline delete icons above
                // and the dedicated Add Post page.
                // PostsManageTable(
                //   postsList: viewModel.postsList,
                //   isLoading: viewModel.getPostsLoading,
                //   onAddPost: () {},
                //   onDeletePost: viewModel.deletePost,
                //   onBack: () {},
                // ),
                const SizedBox(height: 60),
              ],
            ),
          ),
          PostsAppBar(
            isScrolled: viewModel.isScrolled,
            isWide: isWide,
            onHomeTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      floatingActionButton:
          MediaQuery.of(context).size.width >= 800 && viewModel.isAdmin
              ? FloatingActionButton.extended(
                  backgroundColor: AppColors.gradient2,
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AddPostView(viewModel: viewModel),
                    ),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text("Add Post",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: AppFonts.poppinsMedium)),
                )
              : const SizedBox(),
    );
  }

  Widget _buildHero(bool isWide) {
    return SizedBox(
      width: double.infinity,
      height: isWide ? 420 : 300,
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
              child: Icon(
                Icons.article_outlined,
                color: Colors.white,
                size: isWide ? 360 : 240,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isWide ? 100 : 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Reveal(
                    effect: RevealEffect.zoomIn,
                    scale: 0.5,
                    child: Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.white.withValues(alpha: 0.4),
                            width: 2),
                      ),
                      child: const Center(
                        child: Icon(Icons.article_outlined,
                            color: Colors.white, size: 38),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Reveal(
                    effect: RevealEffect.slideDown,
                    distance: 26,
                    delay: const Duration(milliseconds: 120),
                    child: Text(
                      "Posts",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: AppFonts.poppinsBold,
                        fontSize: isWide ? 44 : 26,
                        letterSpacing: 0.5,
                        shadows: const [
                          Shadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 3)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Reveal(
                    effect: RevealEffect.zoomIn,
                    scale: 0.1,
                    delay: const Duration(milliseconds: 240),
                    child: Container(
                      width: 60,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.55),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(2)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Reveal(
                    delay: const Duration(milliseconds: 340),
                    child: Text(
                      "Company updates, industry insights and news from Frankatson Ghana",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontFamily: AppFonts.poppinsLight,
                        fontSize: isWide ? 18 : 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  PostsViewModel viewModelBuilder(BuildContext context) => PostsViewModel();
}
