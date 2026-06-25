import 'package:flutter/material.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:stacked/stacked.dart';

class PartnersViewModel extends BaseViewModel {
  final scrollController = ScrollController();
  bool isScrolled = false;

  List<String> partnerNames = [
    "Kepro",
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
    "Hebei New Century Pharmaceuticals",
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
    AppImages.sunway,
  ];

  void init() {
    scrollController.addListener(() {
      final scrolled = scrollController.offset > 60;
      if (scrolled != isScrolled) {
        isScrolled = scrolled;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
