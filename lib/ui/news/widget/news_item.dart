import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frankoweb/constants/api.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/models/news.dart';
import 'package:frankoweb/ui/shared/custom_button.dart';

class NewsItem extends StatefulWidget {
  final News newsItem;
  const NewsItem({super.key, required this.newsItem});

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
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
                "${Api.dataUrl}${widget.newsItem.image}",
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
                widget.newsItem.title!,
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
                widget.newsItem.description!,
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
                  widget.newsItem.content!,
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
