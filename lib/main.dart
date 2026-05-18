import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/di/injection.dart';
import 'core/localization/localization_helper.dart';
import 'core/observer/bloc_observer.dart';
import 'core/routing/app_router.dart';
import 'core/services/storage/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await StorageService.init();
  await EasyLocalization.ensureInitialized();
  await initDependencies();
  initRouter();

  Bloc.observer = AppBlocObserver();

  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('onboarding_done');

  runApp(
    EasyLocalization(
      supportedLocales: LocalizationHelper.supportedLocales,
      path: LocalizationHelper.path,
      fallbackLocale: LocalizationHelper.fallbackLocale,
      // startLocale: const Locale(AppConstants.arabicLangCode),
      child: const App(),
    ),
  );
}
