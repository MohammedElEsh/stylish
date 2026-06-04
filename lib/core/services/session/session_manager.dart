import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/token_service.dart';
import '../logger/logger_service.dart';

/// High-level application flow states.
///
/// These are the ONLY states the router reasons about.
/// UI screens are NOT allowed to make routing decisions.
enum AppStatus {
  /// Initial value before [SessionManager.initialize] completes.
  /// Treated like [onboardingRequired] for routing purposes.
  initial,

  /// First-launch state: the user has not completed onboarding.
  onboardingRequired,

  /// Onboarding done, but the user is not authenticated.
  unauthenticated,

  /// User is authenticated, but has not yet acknowledged the
  /// post-login "getting started" screen.
  authenticatedNeedsSetup,

  /// User is authenticated and fully ready.
  authenticated,
}

class SessionManager extends ChangeNotifier {
  final SharedPreferences prefs;
  final TokenService tokenService;

  SessionManager(this.prefs, this.tokenService);

  static const _onboardingKey = 'onboarding_done';

  AppStatus _status = AppStatus.initial;

  bool get onboardingDone => prefs.getBool(_onboardingKey) ?? false;

  AppStatus get status => _status;

  /// Called once at app startup — inspects persistent storage
  /// and decides the initial app flow state.
  ///
  /// A returning user with a valid token is treated as [AppStatus.authenticated]
  /// (NOT [AppStatus.authenticatedNeedsSetup]) so that the
  /// "getting started" screen is only shown immediately after a fresh login,
  /// not on every cold start.
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

  // ─── Setup ───────────────────────────────────────────────────────────────

  /// Marks the post-login setup as completed.
  /// Transitions from [AppStatus.authenticatedNeedsSetup]
  /// to [AppStatus.authenticated], letting the router send the user home.
  ///
  /// Idempotent: calling this from any other state is a no-op.
  Future<void> markReady() async {
    if (_status != AppStatus.authenticatedNeedsSetup) {
      LoggerService.w(
        'markReady() called from non-setup state: $_status',
        tag: 'SessionManager',
      );
      return;
    }
    _status = AppStatus.authenticated;
    notifyListeners();
  }

  // ─── Onboarding ──────────────────────────────────────────────────────────

  Future<void> completeOnboarding() async {
    await prefs.setBool(_onboardingKey, true);
    _status = AppStatus.unauthenticated;
    notifyListeners();
  }

  // ─── Auth ────────────────────────────────────────────────────────────────

  /// Persists the tokens and transitions to [AppStatus.authenticatedNeedsSetup].
  /// The router will then redirect the user to the "getting started" screen.
  Future<bool> login({
    required String accessToken,
    String? refreshToken,
  }) async {
    LoggerService.i('login() — saving tokens', tag: 'SessionManager');
    await tokenService.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );

    _status = AppStatus.authenticatedNeedsSetup;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    LoggerService.w('logout() — clearing tokens', tag: 'SessionManager');
    await tokenService.clearTokens();
    _status = AppStatus.unauthenticated;
    notifyListeners();
  }
}
