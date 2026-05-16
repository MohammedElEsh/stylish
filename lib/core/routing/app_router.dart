import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/features/auth/presentation/views/signup_view.dart';

import '../../features/auth/presentation/views/forgot_password_view.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';
import 'route_names.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.onboarding,
  routes: [
    // GoRoute(
    //   path: RouteNames.initial,
    //   builder: (context, state) => const OnboardingScreen(),
    // ),
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
