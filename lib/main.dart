// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:frankoweb/app/locator.dart';
import 'package:frankoweb/app/router.dart';
import 'package:frankoweb/app/theme.dart';
import 'package:frankoweb/constants/app.dart';
import 'package:frankoweb/constants/routes.dart';
import 'package:stacked_services/stacked_services.dart';

void main() async {
  setupLocator();
  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: AppK.debugShowCheckedModeBanner,
      title: AppK.name,
      theme: AppTheme.light,
      initialRoute: Routes.bigScreen,
      onGenerateRoute: AppRouter.generateRoute,
      navigatorKey: StackedService.navigatorKey,
    );
  }
}
