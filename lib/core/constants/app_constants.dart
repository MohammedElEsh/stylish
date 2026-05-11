class ApiEndpoints {
  static const String baseUrl = 'https://api.example.com'; // Change to real URL
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String profile = '/auth/profile';
}

class AppConstants {
  static const String appName = 'Stylish';
  static const int connectTimeout = 15000;
  static const int receiveTimeout = 15000;
  
  // Storage Keys
  static const String tokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'app_theme';
  static const String localeKey = 'app_locale';
}

class AppAssets {
  static const String _imagesPath = 'assets/images';
  static const String _iconsPath = 'assets/icons';

  // Images
  static const String logo = '$_imagesPath/logo.png';
  static const String placeholder = '$_imagesPath/placeholder.png';

  // Icons
  static const String googleIcon = '$_iconsPath/google.svg';
  static const String appleIcon = '$_iconsPath/apple.svg';
  static const String facebookIcon = '$_iconsPath/facebook.svg';
}
