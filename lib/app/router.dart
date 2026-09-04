import 'package:flutter/material.dart';
import 'package:frankoweb/ui/about_us/about_us_view.dart';
import 'package:frankoweb/ui/account/account_view.dart';
import 'package:frankoweb/ui/big_screen/big_screen_view.dart';
import 'package:frankoweb/ui/blog/blog_view.dart';
import 'package:frankoweb/ui/docs/docs_view.dart';
import 'package:frankoweb/ui/gallery/gallery_view.dart';
import 'package:frankoweb/ui/news/news_view.dart';
import 'package:frankoweb/ui/partners/partners_view.dart';
import 'package:frankoweb/ui/shared/animations/animations.dart';
import 'package:frankoweb/ui/small_screen/small_screen_view.dart';
import '../constants/routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.bigScreen:
        return _route(settings, (context) => const BigScreenView());
      case Routes.aboutUsScreen:
        return _route(settings, (context) => const AboutUsView());
      case Routes.postsScreen:
        return _route(settings, (context) => const PostsView());
      case Routes.accountScreen:
        return _route(settings, (context) => const AccountsView());
      case Routes.galleryScreen:
        return _route(settings, (context) => const GalleryScreenView());
      case Routes.partnersScreen:
        return _route(settings, (context) => const PartnersScreenView());
      case Routes.blogScreen:
        return _route(settings, (context) => const BlogScreenView());
      case Routes.smallScreen:
        return _route(settings, (context) => const SmallScreenView());
      case Routes.documentScreen:
        return _route(settings, (context) => const DocumentScreenView());
      default:
        return _route(settings, (context) => const BigScreenView());
    }
  }

  static Route<dynamic> _route(RouteSettings settings, WidgetBuilder builder) =>
      FadePageRoute<dynamic>(builder: builder, settings: settings);
}
