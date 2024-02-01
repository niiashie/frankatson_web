import 'package:flutter/material.dart';
import 'package:frankoweb/ui/about_us/about_us_view.dart';
import 'package:frankoweb/ui/big_screen/big_screen_view.dart';
import 'package:frankoweb/ui/small_screen/small_screen_view.dart';
import '../constants/routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.bigScreen:
        return MaterialPageRoute(builder: (context) => const BigScreenView());
      case Routes.aboutUsScreen:
        return MaterialPageRoute(builder: (context) => const AboutUsView());
      case Routes.smallScreen:
        return MaterialPageRoute(builder: (context) => const SmallScreenView());
      default:
        return MaterialPageRoute(builder: (context) => const BigScreenView());
    }
  }
}