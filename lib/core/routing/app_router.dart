import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/core/routing/router_shell.dart';

import '../../core/di/injection.dart';
import '../../features/auth/presentation/manager/auth_login_cubit.dart';
import '../../features/auth/presentation/manager/auth_register_cubit.dart';
import '../../features/auth/presentation/views/forgot_password_view.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/signup_view.dart';
import '../../features/cart/presentation/manager/cart_cubit.dart';
import '../../features/cart/presentation/views/cart_view.dart';
import '../../features/categories/presentation/manager/categories_cubit.dart';
import '../../features/categories/presentation/views/categories_view.dart';
import '../../features/home/presentation/manager/home_cubit.dart';
import '../../features/home/presentation/views/getting_started_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/onboarding/presentation/manager/onboarding_cubit.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';
import '../../features/profile/presentation/manager/profile_cubit.dart';
import '../../features/profile/presentation/views/profile_view.dart';
import '../../features/wishlist/presentation/manager/wishlist_cubit.dart';
import '../../features/wishlist/presentation/views/wishlist_view.dart';
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

      // Authenticated shell with 5 bottom-nav tabs
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            RouterShell(navigationShell: navigationShell),
        branches: [
          // home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.home,
                builder: (context, state) => BlocProvider(
                  create: (_) => sl<HomeCubit>(),
                  child: const HomeView(),
                ),
              ),
            ],
          ),
          // wishlist
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.wishlist,
                builder: (context, state) => BlocProvider(
                  create: (_) => sl<WishlistCubit>(),
                  child: const WishlistView(),
                ),
              ),
            ],
          ),
          // cart
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.cart,
                builder: (context, state) => BlocProvider(
                  create: (_) => sl<CartCubit>(),
                  child: const CartView(),
                ),
              ),
            ],
          ),
          // search
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.categories,
                builder: (context, state) => BlocProvider(
                  create: (_) => sl<CategoriesCubit>(),
                  child: const CategoriesView(),
                ),
              ),
            ],
          ),

          // settings
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.profile,
                builder: (context, state) => BlocProvider(
                  create: (_) => sl<ProfileCubit>(),
                  child: const ProfileView(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
