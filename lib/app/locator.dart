import 'package:frankoweb/services/app.service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<AppService>(AppService());
  locator.registerSingleton<DialogService>(DialogService());
  locator.registerSingleton<NavigationService>(NavigationService());
  // locator.registerSingleton<LocalStorageService>(LocalStorageService());
}
