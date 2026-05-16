import 'package:flutter/material.dart';

class OnboardingPageController {
  final PageController pageController = PageController();

  void next() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void previous() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void dispose() {
    pageController.dispose();
  }
}
