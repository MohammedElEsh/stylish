import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/features/auth/presentation/views/signup_view.dart';

import '../../features/auth/presentation/views/forgot_password_view.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';
import 'route_names.dart';
import 'router_guard.dart';

late final GoRouter appRouter;

void initRouter() {
  final guard = RouterGuard();

  appRouter = GoRouter(
    initialLocation: guard.initialLocation,
    refreshListenable: guard.refreshListenable,
    redirect: (context, state) => guard.redirect(state.uri.path),
    routes: [
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: RouteNames.signup,
        builder: (context, state) => const SignupView(),
      ),
      GoRoute(
        path: RouteNames.forgotPassword,
        builder: (context, state) => const ForgotPasswordView(),
      ),
      GoRoute(
        path: RouteNames.home,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Home'))),
      ),
    ],
  );
}
