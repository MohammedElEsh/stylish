import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppStatus {
  onboardingRequired,
  unauthenticated,
  authenticated,
}

class SessionManager extends ChangeNotifier {
  final SharedPreferences prefs;

  SessionManager(this.prefs);

  static const _onboardingKey = 'onboarding_done';
  static const _tokenKey = 'token';

  bool get onboardingDone => prefs.getBool(_onboardingKey) ?? false;
  bool get isAuthenticated => prefs.getString(_tokenKey) != null;

  AppStatus get status {
    if (!onboardingDone) return AppStatus.onboardingRequired;
    if (!isAuthenticated) return AppStatus.unauthenticated;
    return AppStatus.authenticated;
  }

  Future<void> completeOnboarding() async {
    await prefs.setBool(_onboardingKey, true);
    notifyListeners();
  }

  Future<void> login(String token) async {
    await prefs.setString(_tokenKey, token);
    notifyListeners();
  }

  Future<void> logout() async {
    await prefs.remove(_tokenKey);
    notifyListeners();
  }
}
