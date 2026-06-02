import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/token_service.dart';
import '../logger/logger_service.dart';

enum AppStatus {
  onboardingRequired,
  unauthenticated,
  authenticated,
}

class SessionManager extends ChangeNotifier {
  final SharedPreferences prefs;
  final TokenService tokenService;

  SessionManager(this.prefs, this.tokenService);

  static const _onboardingKey = 'onboarding_done';

  AppStatus _status = AppStatus.unauthenticated;

  bool get onboardingDone => prefs.getBool(_onboardingKey) ?? false;

  AppStatus get status => _status;

  /// Called at app startup — checks stored token to decide initial state.
  Future<void> initialize() async {
    if (!onboardingDone) {
      _status = AppStatus.onboardingRequired;
      notifyListeners();
      return;
    }

    final token = await tokenService.getAccessToken();
    _status = (token != null && token.isNotEmpty)
        ? AppStatus.authenticated
        : AppStatus.unauthenticated;
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    await prefs.setBool(_onboardingKey, true);
    _status = AppStatus.unauthenticated;
    notifyListeners();
  }

  // ─── Login ─────────────────────────────────────────────────────────────────

  Future<bool> login({
    required String accessToken,
    String? refreshToken,
  }) async {
    LoggerService.i('login() — saving tokens', tag: 'SessionManager');
    await tokenService.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );

    _status = AppStatus.authenticated;
    notifyListeners();
    return true;
  }

  // ─── Logout ────────────────────────────────────────────────────────────────

  Future<void> logout() async {
    LoggerService.w('logout() — clearing tokens', tag: 'SessionManager');
    await tokenService.clearTokens();
    _status = AppStatus.unauthenticated;
    notifyListeners();
  }
}
