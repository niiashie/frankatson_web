import 'package:flutter/material.dart';
import 'package:frankoweb/constants/api.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/ui/shared/custom_button.dart';

class PostsManageTable extends StatelessWidget {
  final List<Map<String, dynamic>> postsList;
  final bool isLoading;
  final VoidCallback onAddPost;
  final void Function(int index) onDeletePost;
  final VoidCallback onBack;

  const PostsManageTable({
    super.key,
    required this.postsList,
    required this.isLoading,
    required this.onAddPost,
    required this.onDeletePost,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 800;
    final tableWidth = isWide
        ? MediaQuery.of(context).size.width * 0.75
        : MediaQuery.of(context).size.width - 48.0;

    return Container(
      width: double.infinity,
      color: const Color(0xFFF8F8F8),
      padding: EdgeInsets.symmetric(
          horizontal: isWide ? 80 : 24, vertical: isWide ? 60 : 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Manage Posts",
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
                ],
              ),
              const Spacer(),
              CustomButton(
                width: 110,
                height: 40,
                borderRadius: 20,
                elevation: 2,
                color: AppColors.gradient2,
                title: const Text("Add Post",
                    style: TextStyle(color: Colors.white)),
                ontap: onAddPost,
              ),
            ],
          ),
          const SizedBox(height: 28),
          Container(
            width: tableWidth,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 2))
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [AppColors.gradient2, AppColors.gradient1],
                      ),
                    ),
                    child: const Row(
                      children: [
                        Expanded(child: Center(child: Text("Image", style: TextStyle(color: Colors.white, fontFamily: AppFonts.poppinsMedium, fontSize: 13)))),
                        Expanded(child: Center(child: Text("Title", style: TextStyle(color: Colors.white, fontFamily: AppFonts.poppinsMedium, fontSize: 13)))),
                        Expanded(child: Center(child: Text("Description", style: TextStyle(color: Colors.white, fontFamily: AppFonts.poppinsMedium, fontSize: 13)))),
                        Expanded(child: Center(child: Text("Author", style: TextStyle(color: Colors.white, fontFamily: AppFonts.poppinsMedium, fontSize: 13)))),
                        Expanded(child: Center(child: Text("Actions", style: TextStyle(color: Colors.white, fontFamily: AppFonts.poppinsMedium, fontSize: 13)))),
                      ],
                    ),
                  ),
                  isLoading
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 48),
                          child: Center(
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: AppColors.gradient2),
                          ),
                        )
                      : ListView.builder(
                          itemCount: postsList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => _PostTableRow(
                            post: postsList[index],
                            isEven: index % 2 == 0,
                            onDelete: () => onDeletePost(index),
                          ),
                        ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: onBack,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back,
                    color: AppColors.gradient2.withValues(alpha: 0.7), size: 15),
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
        ],
      ),
    );
  }
}

class _PostTableRow extends StatelessWidget {
  final Map<String, dynamic> post;
  final bool isEven;
  final VoidCallback onDelete;

  const _PostTableRow({
    required this.post,
    required this.isEven,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final postData = post['post'];
    final isDeleting = post['loading'] == true;

    return Container(
      width: double.infinity,
      height: 80,
      color: isEven ? Colors.white : const Color(0xFFF8F8F8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                child: Image.network(
                  "${Api.dataUrl}${postData.image}",
                  width: 72,
                  height: 54,
                  fit: BoxFit.cover,
                  frameBuilder: (_, child, frame, __) => child,
                  loadingBuilder: (_, child, progress) => progress == null
                      ? child
                      : const SizedBox(
                          width: 72,
                          height: 54,
                          child: Center(
                            child: CircularProgressIndicator(
                                color: AppColors.gradient1, strokeWidth: 1),
                          ),
                        ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text("${postData.title}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13, color: Colors.black87)),
            ),
          ),
          Expanded(
            child: Center(
              child: Text("${postData.description}",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ),
          ),
          Expanded(
            child: Center(
              child: Text("${postData.user!.name}",
                  style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.gradient2,
                      fontFamily: AppFonts.poppinsMedium)),
            ),
          ),
          Expanded(
            child: Center(
              child: isDeleting
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                          strokeWidth: 1.5, color: AppColors.gradient2),
                    )
                  : InkWell(
                      onTap: onDelete,
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.08),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                        ),
                        child: const Icon(Icons.delete_outline,
                            color: Colors.red, size: 17),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
