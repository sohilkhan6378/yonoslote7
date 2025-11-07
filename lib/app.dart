import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/bindings/app_bindings.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/translations/app_translations.dart';

/// Root widget configuring GetMaterialApp with bindings, routes, and localization.
class RummyProApp extends StatelessWidget {
  const RummyProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RummyPro',
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: AppRoutes.splash,
      initialBinding: AppBindings(),
      getPages: AppPages.routes,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: ThemeMode.system,
    );
  }
}
