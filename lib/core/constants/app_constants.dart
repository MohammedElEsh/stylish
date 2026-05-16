class AppConstants {
  static const String appName = 'Stylish';
  static const int connectTimeout = 15000;
  static const int receiveTimeout = 15000;

  static const String arabicLangCode = 'ar';
  static const String englishLangCode = 'en';

  static const String tokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'app_theme';
  static const String localeKey = 'app_locale';
  static const String onboardingKey = 'is_onboarding_completed';
}

class AppAssets {
  static const String _imagesPath = 'assets/images';
  static const String _iconsPath = 'assets/icons';

  static const String logo = '$_imagesPath/logo.png';
  static const String placeholder = '$_imagesPath/placeholder.png';

  static const String googleIcon = '$_iconsPath/google.svg';
  static const String appleIcon = '$_iconsPath/apple.svg';
  static const String facebookIcon = '$_iconsPath/facebook.svg';

  static const String onboarding1 = '$_imagesPath/onboarding1.png';
  static const String onboarding2 = '$_imagesPath/onboarding2.png';
  static const String onboarding3 = '$_imagesPath/onboarding3.png';
}
