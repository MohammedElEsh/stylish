import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'core/routing/app_router.dart';
import 'core/theme/themes/app_themes.dart';
import 'core/wrappers/screen_util_wrapper.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilWrapper(
      child: MaterialApp.router(
        title: 'Stylish',
        debugShowCheckedModeBanner: false,
        theme: AppThemes.light,
        darkTheme: AppThemes.dark,
        themeMode: ThemeMode.system,
        routerConfig: appRouter,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
      ),
    );
  }
}
