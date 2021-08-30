
import 'package:get_it/get_it.dart';
import 'package:ktn_news/Services/Navigation.dart';
import 'package:ktn_news/Services/auth_service.dart';
import 'package:ktn_news/Services/dialog.dart';

import 'Google_analytics.dart';



GetIt locator = GetIt.instance;

void setupLocator() {
   locator.registerLazySingleton(() => AuthService());
   locator.registerLazySingleton(() => NavigationService());
   locator.registerLazySingleton(() => DialogService());
  // locator.registerLazySingleton(() => AnalyticsService());
}