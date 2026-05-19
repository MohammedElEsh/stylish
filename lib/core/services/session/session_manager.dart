import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../storage/secure_storage_service.dart';

enum AppStatus {
  onboardingRequired,
  unauthenticated,
  authenticated,
}

class SessionManager extends ChangeNotifier {
  final SharedPreferences prefs;
  final SecureStorageService secureStorage;

  SessionManager(this.prefs, this.secureStorage);

  static const _onboardingKey = 'onboarding_done';
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  AppStatus _status = AppStatus.unauthenticated;

  bool get onboardingDone => prefs.getBool(_onboardingKey) ?? false;
  AppStatus get status => _status;

  Future<void> initialize() async {
    if (!onboardingDone) {
      _status = AppStatus.onboardingRequired;
    } else {
      final token = await secureStorage.read(_accessTokenKey);
      _status = (token != null && token.isNotEmpty)
          ? AppStatus.authenticated
          : AppStatus.unauthenticated;
    }
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    await prefs.setBool(_onboardingKey, true);
    _status = AppStatus.unauthenticated;
    notifyListeners();
  }

  Future<void> login({required String accessToken, String? refreshToken}) async {
    await secureStorage.write(_accessTokenKey, accessToken);
    if (refreshToken != null) {
      await secureStorage.write(_refreshTokenKey, refreshToken);
    }
    _status = AppStatus.authenticated;
    notifyListeners();
  }

  Future<void> logout() async {
    await secureStorage.delete(_accessTokenKey);
    await secureStorage.delete(_refreshTokenKey);
    _status = AppStatus.unauthenticated;
    notifyListeners();
  }
}
