import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/features/auth/presentation/screens/login_screen.dart';

import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
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
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: RouteNames.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RouteNames.home,
      builder: (context, state) =>
          const Scaffold(body: Center(child: Text('Home'))),
    ),
  ],
);
