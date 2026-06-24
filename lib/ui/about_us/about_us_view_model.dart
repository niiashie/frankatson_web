import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AboutUsViewModel extends BaseViewModel {
  final scrollController = ScrollController();
  bool isScrolled = false;

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
