import '../../../../core/constants/app_constants.dart';

class OnboardingPage {
  final String image;
  final String titleKey;
  final String descriptionKey;

  const OnboardingPage({
    required this.image,
    required this.titleKey,
    required this.descriptionKey,
  });
}

const List<OnboardingPage> onboardingPages = [
  OnboardingPage(
    image: AppAssets.onboarding1,
    titleKey: 'onboarding.onboarding_title_1',
    descriptionKey: 'onboarding.onboarding_subtitle_1',
  ),
  OnboardingPage(
    image: AppAssets.onboarding2,
    titleKey: 'onboarding.onboarding_title_2',
    descriptionKey: 'onboarding.onboarding_subtitle_2',
  ),
  OnboardingPage(
    image: AppAssets.onboarding3,
    titleKey: 'onboarding.onboarding_title_3',
    descriptionKey: 'onboarding.onboarding_subtitle_3',
  ),
];
