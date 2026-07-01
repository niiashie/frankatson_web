import 'package:flutter/material.dart';
import 'package:frankoweb/app/locator.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/models/news.dart';
import 'package:frankoweb/services/app.service.dart';
import 'package:frankoweb/ui/news/news_view_model.dart';
import 'package:frankoweb/ui/news/widget/post_create_form.dart';
import 'package:frankoweb/ui/news/widget/post_public_list.dart';
import 'package:frankoweb/ui/news/widget/posts_app_bar.dart';
import 'package:frankoweb/ui/news/widget/posts_manage_table.dart';
import 'package:stacked/stacked.dart';

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
  Widget builder(BuildContext context, PostsViewModel viewModel, Widget? child) {
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
                Visibility(
                  visible: !viewModel.showManagesPosts,
                  child: PostPublicList(
                    isLoading: viewModel.getPostsLoading,
                    posts: viewModel.postsList
                        .map((e) => e['post'] as Post)
                        .toList(),
                    isWide: isWide,
                  ),
                ),
                Visibility(
                  visible: viewModel.showManagesPosts,
                  child: Visibility(
                    visible: !viewModel.showAddPost,
                    replacement: PostCreateForm(
                      formKey: viewModel.postKey,
                      titleController: viewModel.title,
                      descriptionController: viewModel.description,
                      contentController: viewModel.content,
                      hasFile: viewModel.file != null,
                      bytesData: viewModel.bytesData,
                      isLoading: viewModel.createPostLoading,
                      onPickFile: viewModel.pickFile,
                      onClearImage: viewModel.clearSelectedImage,
                      onSubmit: viewModel.createPost,
                      onBack: viewModel.backToPosts,
                    ),
                    child: PostsManageTable(
                      postsList: viewModel.postsList,
                      isLoading: viewModel.getPostsLoading,
                      onAddPost: viewModel.displayAddPost,
                      onDeletePost: viewModel.deletePost,
                      onBack: viewModel.backToPosts,
                    ),
                  ),
                ),
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
      floatingActionButton: MediaQuery.of(context).size.width >= 800
          ? FutureBuilder(
              future: locator<AppService>().getUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) return const SizedBox();
                  if (snapshot.hasData &&
                      snapshot.data!.isNotEmpty &&
                      snapshot.data!['role'] == "admin") {
                    return Visibility(
                      visible: !viewModel.showAddPost,
                      child: FloatingActionButton.extended(
                        backgroundColor: AppColors.gradient2,
                        onPressed: viewModel.displayManagePosts,
                        icon: const Icon(Icons.tune, color: Colors.white),
                        label: const Text("Manage Posts",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.poppinsMedium)),
                      ),
                    );
                  }
                }
                return const SizedBox();
              })
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
              padding:
                  EdgeInsets.symmetric(horizontal: isWide ? 100 : 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
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
                  const SizedBox(height: 20),
                  Text(
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
                  const SizedBox(height: 14),
                  Container(
                    width: 60,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.55),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(2)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Company updates, industry insights and news from Frankatson Ghana",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontFamily: AppFonts.poppinsLight,
                      fontSize: isWide ? 18 : 13,
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
