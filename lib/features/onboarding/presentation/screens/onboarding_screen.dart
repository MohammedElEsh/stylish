import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/colors/app_colors.dart';
import '../../data/models/onboarding_model.dart' as models;
import '../view_models/onboarding_cubit.dart';
import '../view_models/onboarding_state.dart';
import '../widgets/onboarding_dots.dart';
import '../widgets/onboarding_footer.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/onboarding_item.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage(OnboardingCubit cubit, int current) {
    if (current >= models.onboardingPages.length - 1) {
      cubit.complete();
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OnboardingCubit>(),
      child: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state.completed) {
            context.go(RouteNames.login);
          }
        },
        builder: (context, state) {
          final cubit = context.read<OnboardingCubit>();

          final currentIndex = state.currentPage;

          final isFirst = currentIndex == 0;
          final isLast = currentIndex == models.onboardingPages.length - 1;

          return Scaffold(
            backgroundColor: AppColors.surfaceLight,
            body: SafeArea(
              child: Column(
                children: [
                  OnboardingHeader(
                    current: currentIndex + 1,
                    total: models.onboardingPages.length,
                    showSkip: !isLast,
                    onSkip: isLast ? null : cubit.complete,
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: models.onboardingPages.length,
                      onPageChanged: cubit.onPageChanged,
                      itemBuilder: (_, i) {
                        final page = models.onboardingPages[i];

                        return OnboardingItem(
                          image: page.image,
                          title: page.titleKey.tr(),
                          description: page.descriptionKey.tr(),
                        );
                      },
                    ),
                  ),
                  OnboardingDots(
                    count: models.onboardingPages.length,
                    currentIndex: currentIndex,
                  ),
                  OnboardingFooter(
                    isFirst: isFirst,
                    isLast: isLast,
                    onPrev: _previousPage,
                    onNext: () => _nextPage(cubit, currentIndex),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
