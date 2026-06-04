import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/injection.dart';
import '../../features/auth/presentation/manager/auth_login_cubit.dart';
import '../../features/auth/presentation/manager/auth_register_cubit.dart';
import '../../features/auth/presentation/views/forgot_password_view.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/signup_view.dart';
import '../../features/home/presentation/views/getting_started_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/onboarding/presentation/manager/onboarding_cubit.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';
import '../dev/auth_flow_test.dart';
import '../services/session/session_manager.dart';
import '../shared/feedback/feedback_handler.dart';
import 'route_names.dart';
import 'router_guard.dart';

late final GoRouter appRouter;

void initRouter() {
  final guard = RouterGuard(sl<SessionManager>());

  appRouter = GoRouter(
    navigatorKey: FeedbackHandler.navigatorKey,
    initialLocation: guard.initialLocation,
    refreshListenable: guard.refreshListenable,
    redirect: guard.redirect,
    routes: [
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<OnboardingCubit>(),
          child: const OnboardingView(),
        ),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<AuthLoginCubit>(),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: RouteNames.signup,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<AuthRegisterCubit>(),
          child: const SignupView(),
        ),
      ),
      GoRoute(
        path: RouteNames.forgotPassword,
        builder: (context, state) => const ForgotPasswordView(),
      ),
      GoRoute(
        path: RouteNames.gettingStarted,
        builder: (context, state) => const GettingStartedView(),
      ),
      GoRoute(
        path: RouteNames.home,
        builder: (context, state) => const HomeView(),
      ),

      /// Dev-only destination used during auth flow development.

      GoRoute(
        path: RouteNames.authFlowTest,
        builder: (context, state) => const AuthFlowTest(),
      ),
    ],
  );
}
