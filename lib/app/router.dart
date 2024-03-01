import 'package:flutter/material.dart';
import 'package:frankoweb/ui/about_us/about_us_view.dart';
import 'package:frankoweb/ui/account/account_view.dart';
import 'package:frankoweb/ui/big_screen/big_screen_view.dart';
import 'package:frankoweb/ui/blog/blog_view.dart';
import 'package:frankoweb/ui/docs/docs_view.dart';
import 'package:frankoweb/ui/gallery/gallery_view.dart';
import 'package:frankoweb/ui/news/news_view.dart';
import 'package:frankoweb/ui/partners/partners_view.dart';
import 'package:frankoweb/ui/small_screen/small_screen_view.dart';
import '../constants/routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.bigScreen:
        return MaterialPageRoute(builder: (context) => const BigScreenView());
      case Routes.aboutUsScreen:
        return MaterialPageRoute(builder: (context) => const AboutUsView());
      case Routes.newsScreen:
        return MaterialPageRoute(builder: (context) => const NewsView());
      case Routes.accountScreen:
        return MaterialPageRoute(builder: (context) => const AccountsView());
      case Routes.galleryScreen:
        return MaterialPageRoute(
            builder: (context) => const GalleryScreenView());
      case Routes.partnersScreen:
        return MaterialPageRoute(
            builder: (context) => const PartnersScreenView());
      case Routes.blogScreen:
        return MaterialPageRoute(builder: (context) => const BlogScreenView());
      case Routes.smallScreen:
        return MaterialPageRoute(builder: (context) => const SmallScreenView());
      case Routes.documentScreen:
        return MaterialPageRoute(
            builder: (context) => const DocumentScreenView());
      default:
        return MaterialPageRoute(builder: (context) => const BigScreenView());
    }
  }
}
