import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frankoweb/constants/api.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/models/blog_category.dart';
import 'package:frankoweb/ui/shared/custom_button.dart';

class BlogCategoryItem extends StatefulWidget {
  final BlogCategory blogCategoryItem;
  final Function(BlogCategory) viewBlog;
  const BlogCategoryItem({
    super.key,
    required this.blogCategoryItem,
    required this.viewBlog,
  });

  @override
  State<BlogCategoryItem> createState() => _BlogCategoryItemState();
}

class _BlogCategoryItemState extends State<BlogCategoryItem> {
  bool showMore = false;

  @override
  void initState() {
    super.initState();
    showMore = false;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 2,
      child: Container(
        width: 300,
        padding: const EdgeInsets.only(bottom: 5),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: Image.network(
                "${Api.dataUrl}${widget.blogCategoryItem.image}",
                width: double.infinity,
                height: 200,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                widget.blogCategoryItem.name!,
                textAlign: TextAlign.left,
                style:
                    const TextStyle(color: AppColors.gradient2, fontSize: 12),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                widget.blogCategoryItem.description!,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
                width: double.infinity,
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: CustomButton(
                      width: 100,
                      height: 35,
                      color: AppColors.gradient2,
                      title: const Text(
                        "View Blogs",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      ontap: () {
                        widget.viewBlog(widget.blogCategoryItem);
                      },
                    ),
                  ),
                )),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
