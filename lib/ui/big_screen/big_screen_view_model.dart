import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frankoweb/api/news_api.dart';
import 'package:frankoweb/app/locator.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:frankoweb/models/api_response.dart';
import 'package:frankoweb/models/gallery.dart';
import 'package:frankoweb/services/app.service.dart';
import 'package:stacked/stacked.dart';

class BigScreenViewModel extends BaseViewModel {
  var key0 = GlobalKey();
  var key1 = GlobalKey();
  var key2 = GlobalKey();
  var key3 = GlobalKey();
  var key4 = GlobalKey();
  var key5 = GlobalKey();
  ScrollController scrollController = ScrollController();
  bool showScrollUp = false;
  NewsApi newsApi = NewsApi();
  var appService = locator<AppService>();
  List<String> galleryImages = [];
  List<String> partnerNames = [
    "kepro",
    "VMD Livestock Pharma",
    "Arion Fasoli",
    "Hipra",
    "Biomar",
    "Laprovet",
    "Champrix",
    "Supreme Equipment",
    "Vetko",
    "Nutriblock",
    "SKM Pharma",
    "Hebei New Centry Pharmaceuticals"
  ];
  List<String> partnerImages = [
    AppImages.kepro,
    AppImages.vmd,
    AppImages.arion,
    AppImages.hipra,
    AppImages.biomar,
    AppImages.laprovet,
    AppImages.champrix,
    AppImages.supreme,
    AppImages.vetko,
    AppImages.nutriblock,
    AppImages.skm,
    AppImages.sunway
  ];

  init() {
    scrollController.addListener(() {
      if (scrollController.offset > 900) {
        showScrollUp = true;
      } else {
        showScrollUp = false;
      }

      rebuildUi();

      //debugPrint("Position : ${scrollController.offset}");
    });
    checkLocalStorage();
    getPics();
  }

  getPics() async {
    try {
      ApiResponse response = await newsApi.getGallery();
      if (response.ok) {
        List<dynamic> picList = response.data;
        for (var obj in picList) {
          galleryImages.add(Gallery.fromJson(obj).image!);
          // items.add(GalleryItem(
          //     gallery: Gallery.fromJson(obj),
          //     onDeleteCompleted: () {
          //       getPics();
          //     }));
        }

        rebuildUi();
      }
    } on DioException catch (e) {
      ApiResponse errorResponse = ApiResponse.parse(e.response);
      debugPrint(errorResponse.message);
      appService.showErrorFromApiRequest(message: errorResponse.message!);
    }
  }

  checkLocalStorage() async {
    Map<String, String> local = await appService.getUser();
    if (local.isNotEmpty) {
      debugPrint("User present");
    } else {
      debugPrint("User absent");
    }
  }

  moveUp() {
    Scrollable.ensureVisible(key0.currentContext!,
        duration: const Duration(seconds: 2));
  }

  aboutUsClicked() {
    Scrollable.ensureVisible(key1.currentContext!,
        duration: const Duration(seconds: 2));
  }

  contactUsClicked() {
    Scrollable.ensureVisible(key5.currentContext!,
        duration: const Duration(seconds: 2));
  }

  serviceClicked() {
    Scrollable.ensureVisible(key2.currentContext!,
        duration: const Duration(seconds: 2));
  }

  partnersClicked() {
    Scrollable.ensureVisible(key3.currentContext!,
        duration: const Duration(seconds: 2));
  }

  teamClicked() {
    Scrollable.ensureVisible(key4.currentContext!,
        duration: const Duration(seconds: 2));
  }
}
