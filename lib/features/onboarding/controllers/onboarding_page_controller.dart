import 'package:flutter/material.dart';

import '../data/models/onboarding_model.dart';

class OnboardingPageController {
  final PageController pageController = PageController();

  void next(int current, VoidCallback onLast) {
    if (current >= onboardingPages.length - 1) {
      onLast();
      return;
    }

    pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void previous() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void dispose() {
    pageController.dispose();
  }
}
