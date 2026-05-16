import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/session/session_manager.dart';
import 'route_names.dart';

class RouterGuard {
  final SessionManager _sessionManager;

  RouterGuard() : _sessionManager = GetIt.instance<SessionManager>();

  String get initialLocation {
    return _sessionManager.onboardingDone
        ? RouteNames.login
        : RouteNames.onboarding;
  }

  ChangeNotifier get refreshListenable => _sessionManager;

  String? redirect(String path) {
    if (!_sessionManager.onboardingDone) return RouteNames.onboarding;
    if (!_sessionManager.isAuthenticated) return RouteNames.login;
    if (path == RouteNames.login || path == RouteNames.onboarding) {
      return RouteNames.home;
    }
    return null;
  }
}
