import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizationHelper {
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
  ];

  static const String path = 'assets/translations';

  static Locale get fallbackLocale => const Locale('en');

  static bool isArabic(BuildContext context) =>
      context.locale.languageCode == 'ar';
}
