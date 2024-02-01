import 'package:flutter/material.dart';
import 'package:frankoweb/constants/images.dart';
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
