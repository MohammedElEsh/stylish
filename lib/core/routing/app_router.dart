import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';

// Import pages from features (dummy for now to ensure compilation)
// In a real scenario, these would be imported from features/
final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.initial,
  routes: [
    GoRoute(
      path: RouteNames.initial,
      builder: (context, state) => const Scaffold(body: Center(child: Text('Splash'))),
    ),
    GoRoute(
      path: RouteNames.onboarding,
      builder: (context, state) => const Scaffold(body: Center(child: Text('Onboarding'))),
    ),
    GoRoute(
      path: RouteNames.login,
      builder: (context, state) => const Scaffold(body: Center(child: Text('Login'))),
    ),
    GoRoute(
      path: RouteNames.home,
      builder: (context, state) => const Scaffold(body: Center(child: Text('Home'))),
    ),
  ],
);
