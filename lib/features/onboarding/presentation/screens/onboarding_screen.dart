import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/colors/app_colors.dart';
import '../../controllers/onboarding_page_controller.dart';
import '../../data/models/onboarding_model.dart';
import '../view_models/onboarding_cubit.dart';
import '../view_models/onboarding_state.dart';
import '../widgets/onboarding_dots.dart';
import '../widgets/onboarding_footer.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/onboarding_item.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OnboardingCubit>(),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatefulWidget {
  const _OnboardingView();

  @override
  State<_OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<_OnboardingView> {
  final controller = OnboardingPageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state.completed) {
          context.go(RouteNames.login);
        }
      },
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();

        final current = state.currentPage;
        final isLast = current == onboardingPages.length - 1;

        return Scaffold(
          backgroundColor: AppColors.surfaceLight,
          body: SafeArea(
            child: Column(
              children: [
                OnboardingHeader(
                  current: current + 1,
                  total: onboardingPages.length,
                  showSkip: !isLast,
                  onSkip: cubit.complete,
                ),
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    itemCount: onboardingPages.length,
                    onPageChanged: cubit.onPageChanged,
                    itemBuilder: (_, i) {
                      final page = onboardingPages[i];

                      return OnboardingItem(
                        image: page.image,
                        title: page.titleKey.tr(),
                        description: page.descriptionKey.tr(),
                      );
                    },
                  ),
                ),
                OnboardingDots(
                  count: onboardingPages.length,
                  currentIndex: current,
                ),
                OnboardingFooter(
                  isFirst: current == 0,
                  isLast: isLast,
                  onPrev: controller.previous,
                  onNext: () => controller.next(current, cubit.complete),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
