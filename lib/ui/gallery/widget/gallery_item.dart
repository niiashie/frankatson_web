import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frankoweb/api/news_api.dart';
import 'package:frankoweb/app/locator.dart';
import 'package:frankoweb/constants/api.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/models/api_response.dart';
import 'package:frankoweb/models/gallery.dart';
import 'package:frankoweb/services/app.service.dart';
import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../services/dialog.service.dart' as dialog;

class GalleryItem extends StatefulWidget {
  final Gallery gallery;
  final VoidCallback onDeleteCompleted;
  const GalleryItem(
      {super.key, required this.gallery, required this.onDeleteCompleted});

  @override
  State<GalleryItem> createState() => _GalleryItemState();
}

class _GalleryItemState extends State<GalleryItem> {
  bool showLoading = false;
  var appService = locator<AppService>();

  @override
  Widget build(BuildContext context) {
    var appService = locator<AppService>();
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 185,
              height: 185,
              child: Material(
                color: Colors.transparent,
                elevation: 1,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: Container(
                  width: 185,
                  height: 185,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          child: Image.network(
                            "${Api.dataUrl}${widget.gallery.image!}",
                            width: 185,
                            height: 165,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "${DateFormat.yMMMd().format(widget.gallery.date!)} ${DateFormat.jm().format(widget.gallery.date!)}",
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Visibility(
                visible:
                    appService.localStorage['role'] == "staff" ? true : false,
                child: InkWell(
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.gradient2),
                    child: showLoading == true
                        ? const Center(
                            child: SizedBox(
                              width: 15,
                              height: 15,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : const Center(
                            child: Icon(
                              Icons.clear,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                  ),
                  onTap: () {
                    deletePic();
                  },
                )),
          )
        ],
      ),
    );
  }

  deletePic() {
    dialog.DialogService().show(
        title: "Delete Gallery",
        message: "Do you really want to delete gallery",
        okayBtnText: "Yes",
        cancelBtnText: "No",
        onOkayTap: () {
          Navigator.of(StackedService.navigatorKey!.currentContext!).pop();
          deletePictureRequest();
        },
        onCancelTap: () {
          Navigator.of(StackedService.navigatorKey!.currentContext!).pop();
        });
  }

  deletePictureRequest() async {
    NewsApi newsApi = NewsApi();
    try {
      showLoading = true;
      setState(() {});
      ApiResponse deletePictureResponse =
          await newsApi.deleteGallery(widget.gallery.id.toString());
      if (deletePictureResponse.ok) {
        showLoading = false;
        setState(() {});
        widget.onDeleteCompleted();
      }
    } on DioException catch (e) {
      showLoading = false;
      setState(() {});
      ApiResponse errorResponse = ApiResponse.parse(e.response);
      debugPrint(errorResponse.message);
      appService.showErrorFromApiRequest(message: errorResponse.message!);
    }
  }
}
