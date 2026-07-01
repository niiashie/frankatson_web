import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frankoweb/constants/api.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/models/news.dart';
import 'package:frankoweb/ui/shared/custom_button.dart';

class PostItem extends StatefulWidget {
  final Post postItem;
  const PostItem({super.key, required this.postItem});

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool showMore = false;

  @override
  void initState() {
    debugPrint("image url : ${Api.dataUrl}${widget.postItem.image}");
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
            Builder(builder: (context) {
              final url = "${Api.dataUrl}${widget.postItem.image}";
              debugPrint("PostItem image URL: $url");
              return ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: Image.network(
                  url,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.fill,
                  errorBuilder: (_, error, __) => Container(
                    width: double.infinity,
                    height: 200,
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
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                widget.postItem.title!,
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
                widget.postItem.description!,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Visibility(
              visible: showMore,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  widget.postItem.content!,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Visibility(
                      visible: !showMore,
                      replacement: CustomButton(
                        width: 120,
                        height: 35,
                        color: AppColors.gradient2,
                        title: const Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "View Less",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.chevron_right,
                              size: 12,
                              color: Colors.white,
                            )
                          ],
                        ),
                        ontap: () {
                          setState(() {
                            showMore = false;
                          });
                        },
                      ),
                      child: CustomButton(
                        width: 120,
                        height: 35,
                        color: AppColors.gradient2,
                        title: const Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "View More",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.chevron_right,
                              size: 12,
                              color: Colors.white,
                            )
                          ],
                        ),
                        ontap: () {
                          setState(() {
                            showMore = true;
                          });
                        },
                      ),
                    ),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
