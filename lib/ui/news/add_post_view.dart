import 'package:flutter/material.dart';
import 'package:frankoweb/ui/news/news_view_model.dart';
import 'package:frankoweb/ui/news/widget/post_create_form.dart';
import 'package:frankoweb/ui/news/widget/posts_app_bar.dart';

class AddPostView extends StatelessWidget {
  final PostsViewModel viewModel;
  const AddPostView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 800;

    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    PostCreateForm(
                      formKey: viewModel.postKey,
                      titleController: viewModel.title,
                      descriptionController: viewModel.description,
                      contentController: viewModel.content,
                      hasFile: viewModel.file != null,
                      bytesData: viewModel.bytesData,
                      isVideo: viewModel.coverIsVideo,
                      fileName: viewModel.coverFileName,
                      fileSizeLabel: viewModel.coverSizeLabel,
                      videoUrl: viewModel.coverObjectUrl,
                      isLoading: viewModel.createPostLoading,
                      onPickFile: viewModel.pickFile,
                      onClearImage: viewModel.clearSelectedImage,
                      onSubmit: () => viewModel.createPost(
                        onSuccess: () => Navigator.of(context).pop(),
                      ),
                      onBack: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
              PostsAppBar(
                isScrolled: true,
                isWide: isWide,
                subLabel: "Add Post",
                onHomeTap: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
                onPostsTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }
}
