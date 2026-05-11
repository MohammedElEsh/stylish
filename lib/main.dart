import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'core/bloc/app_bloc_observer.dart';
import 'core/di/injection.dart';
import 'core/localization/localization_helper.dart';
import 'core/services/storage/storage_service.dart';
import 'app.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Core Services
  await StorageService.init();
  await EasyLocalization.ensureInitialized();
  await initDependencies();

  Bloc.observer = AppBlocObserver();

  runApp(
    EasyLocalization(
      supportedLocales: LocalizationHelper.supportedLocales,
      path: LocalizationHelper.path,
      fallbackLocale: LocalizationHelper.fallbackLocale,
      child: const App(),
    ),
  );
}
