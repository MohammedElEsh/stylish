import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/route_names.dart';
import '../../data/models/onboarding_model.dart';
import '../manager/onboarding_cubit.dart';
import '../manager/onboarding_state.dart';
import '../widgets/onboarding_dots.dart';
import '../widgets/onboarding_footer.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/onboarding_item.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state.completed) {
          context.go(RouteNames.login);
        }
      },
      builder: (context, state) {
        final current = state.currentPage;
        final totalPages = onboardingPages.length;
        final isLast = current == totalPages - 1;

        return Scaffold(
          backgroundColor: theme.colorScheme.surface,
          body: SafeArea(
            child: Column(
              children: [
                OnboardingHeader(
                  current: current + 1,
                  total: totalPages,
                  showSkip: !isLast,
                  onSkip: context.read<OnboardingCubit>().complete,
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: totalPages,
                    onPageChanged:
                        context.read<OnboardingCubit>().onPageChanged,
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
                  count: totalPages,
                  currentIndex: current,
                ),
                OnboardingFooter(
                  isFirst: current == 0,
                  isLast: isLast,
                  onPrev: _previousPage,
                  onNext: () {
                    if (isLast) {
                      context.read<OnboardingCubit>().complete();
                    } else {
                      _nextPage();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
