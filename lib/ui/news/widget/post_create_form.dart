import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:frankoweb/ui/news/widget/cover_video_preview.dart';
import 'package:frankoweb/ui/shared/custom_button.dart';
import 'package:frankoweb/ui/shared/custom_form_field.dart';

class PostCreateForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController? titleController;
  final TextEditingController? descriptionController;
  final TextEditingController? contentController;
  final bool hasFile;
  final Uint8List? bytesData;
  final bool isVideo;
  final String? fileName;
  final String? fileSizeLabel;
  final String? videoUrl;
  final bool isLoading;
  final VoidCallback onPickFile;
  final VoidCallback onClearImage;
  final VoidCallback onSubmit;
  final VoidCallback onBack;

  const PostCreateForm({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.descriptionController,
    required this.contentController,
    required this.hasFile,
    required this.bytesData,
    this.isVideo = false,
    this.fileName,
    this.fileSizeLabel,
    this.videoUrl,
    required this.isLoading,
    required this.onPickFile,
    required this.onClearImage,
    required this.onSubmit,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 800;

    return Container(
      width: double.infinity,
      color: const Color(0xFFF8F8F8),
      padding: EdgeInsets.symmetric(
          horizontal: isWide ? 80 : 24, vertical: isWide ? 60 : 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Create Post",
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
          const SizedBox(height: 6),
          const Text(
            "Fill in the details required to add a post",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 32),
          Center(
            child: Container(
              width: isWide ? 480 : double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, 3))
                ],
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Material(
                      elevation: 2,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Image.asset(AppImages.logo,
                              width: 56, height: 56),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomFormField(
                      hintText: "Enter post title",
                      label: " Title",
                      filled: true,
                      controller: titleController,
                      fillColor: const Color(0xFFF8F8F8),
                      prefixIcon: const Icon(Icons.title_outlined,
                          size: 15, color: Colors.grey),
                      validator: (String? value) {
                        if (value!.isEmpty) return "Title is required.";
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomFormField(
                      hintText: "Enter brief description",
                      label: " Brief Description",
                      filled: true,
                      controller: descriptionController,
                      maxLines: null,
                      fillColor: const Color(0xFFF8F8F8),
                      prefixIcon: const Icon(Icons.short_text,
                          size: 15, color: Colors.grey),
                      validator: (String? value) {
                        if (value!.isEmpty)
                          return "Brief description is required.";
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomFormField(
                      hintText: "Enter post content",
                      label: " Content",
                      filled: true,
                      controller: contentController,
                      maxLines: null,
                      fillColor: const Color(0xFFF8F8F8),
                      prefixIcon: const Icon(Icons.article_outlined,
                          size: 15, color: Colors.grey),
                      validator: (String? value) {
                        if (value!.isEmpty) return "Content is required.";
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _CoverMediaPicker(
                      hasFile: hasFile,
                      bytesData: bytesData,
                      isVideo: isVideo,
                      fileName: fileName,
                      fileSizeLabel: fileSizeLabel,
                      videoUrl: videoUrl,
                      onPickFile: onPickFile,
                      onClearImage: onClearImage,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      width: double.infinity,
                      maxWidth: double.infinity,
                      height: 46,
                      isLoading: isLoading,
                      color: AppColors.gradient2,
                      title: const Text("Publish Post",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: AppFonts.poppinsMedium)),
                      elevation: 2,
                      ontap: onSubmit,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: InkWell(
              onTap: onBack,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back,
                      color: AppColors.gradient2.withValues(alpha: 0.7),
                      size: 14),
                  const SizedBox(width: 8),
                  Text(
                    "Back To Posts",
                    style: TextStyle(
                      color: AppColors.gradient2.withValues(alpha: 0.7),
                      fontFamily: AppFonts.poppinsMedium,
                      fontSize: 13,
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
}

class _CoverMediaPicker extends StatelessWidget {
  final bool hasFile;
  final Uint8List? bytesData;
  final bool isVideo;
  final String? fileName;
  final String? fileSizeLabel;
  final String? videoUrl;
  final VoidCallback onPickFile;
  final VoidCallback onClearImage;

  const _CoverMediaPicker({
    required this.hasFile,
    required this.bytesData,
    required this.isVideo,
    required this.fileName,
    required this.fileSizeLabel,
    required this.videoUrl,
    required this.onPickFile,
    required this.onClearImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Cover Image or Video",
          style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontFamily: AppFonts.poppinsMedium),
        ),
        const SizedBox(height: 4),
        const Text(
          "Upload an image or a video — max 100 MB",
          style: TextStyle(color: Colors.grey, fontSize: 11),
        ),
        const SizedBox(height: 8),
        if (hasFile) ...[
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Stack(
              children: [
                if (isVideo && videoUrl != null)
                  CoverVideoPreview(src: videoUrl!)
                else if (isVideo || bytesData == null)
                  Container(
                    width: double.infinity,
                    height: 140,
                    color: const Color(0xFFF1F1F1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isVideo
                              ? Icons.movie_creation_outlined
                              : Icons.image_outlined,
                          size: 34,
                          color: AppColors.gradient2,
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            fileName ??
                                (isVideo ? "Video selected" : "File selected"),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Image.memory(
                    bytesData!,
                    width: double.infinity,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: onClearImage,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.gradient2),
                      child: const Center(
                          child: Icon(Icons.close,
                              size: 15, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isVideo && videoUrl != null) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.play_circle_outline,
                    size: 14, color: AppColors.gradient2),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    "Play the video to confirm it's the right one before publishing.",
                    style: TextStyle(
                        fontSize: 11,
                        color: AppColors.gradient2.withValues(alpha: 0.9)),
                  ),
                ),
              ],
            ),
          ],
          if (fileSizeLabel != null && fileSizeLabel!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              "${isVideo ? 'Video' : 'Image'} · ${fileSizeLabel!}",
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
          const SizedBox(height: 10),
        ],
        CustomButton(
          color: AppColors.gradient1,
          height: 40,
          width: 180,
          elevation: 1,
          ontap: onPickFile,
          title: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.perm_media_outlined, size: 14, color: Colors.white),
              SizedBox(width: 6),
              Text("Select Image / Video",
                  style: TextStyle(color: Colors.white, fontSize: 13)),
            ],
          ),
        ),
      ],
    );
  }
}
