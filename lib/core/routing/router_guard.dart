import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../services/session/session_manager.dart';
import 'route_names.dart';

class RouterGuard {
  final SessionManager _sessionManager;

  RouterGuard() : _sessionManager = GetIt.instance<SessionManager>();

  String get initialLocation {
    switch (_sessionManager.status) {
      case AppStatus.onboardingRequired:
        return RouteNames.onboarding;
      case AppStatus.unauthenticated:
        return RouteNames.login;
      case AppStatus.authenticated:
        return RouteNames.home;
    }
  }

  ChangeNotifier get refreshListenable => _sessionManager;

  String? redirect(BuildContext context, GoRouterState state) {
    final location = state.matchedLocation;

    switch (_sessionManager.status) {
      case AppStatus.onboardingRequired:
        if (location == RouteNames.onboarding) return null;
        return RouteNames.onboarding;

      case AppStatus.unauthenticated:
        final allowed = {
          RouteNames.login,
          RouteNames.signup,
          RouteNames.forgotPassword,
        };
        if (allowed.contains(location)) return null;
        return RouteNames.login;

      case AppStatus.authenticated:
        final blocked = {
          RouteNames.login,
          RouteNames.signup,
          RouteNames.forgotPassword,
          RouteNames.onboarding,
        };
        if (blocked.contains(location)) return RouteNames.home;
        return null;
    }
  }
}
