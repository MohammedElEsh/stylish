/// Legacy string constants.
///
/// DEPRECATED: Use [Strings] from 'package:stylish/core/localization/strings.dart'
/// for all localized text. This file is retained only for non-localized
/// application constants.
class AppStrings {
  static const String appName = 'Stylish';

  // Shared
  static const String sharedGetStarted = 'shared.get_started';
  static const String sharedRetry = 'shared.retry';
  static const String sharedNoInternet = 'shared.no_internet';

  // Onboarding - Actions
  static const String onboardingSkip = 'onboarding.actions.skip';
  static const String onboardingPrev = 'onboarding.actions.prev';
  static const String onboardingNext = 'onboarding.actions.next';
  static const String onboardingGetStarted = 'onboarding.actions.get_started';

  // Onboarding - Steps
  static const String onboardingStepTitle1 = 'onboarding.steps.title1';
  static const String onboardingStepSubtitle1 = 'onboarding.steps.subtitle1';
  static const String onboardingStepTitle2 = 'onboarding.steps.title2';
  static const String onboardingStepSubtitle2 = 'onboarding.steps.subtitle2';
  static const String onboardingStepTitle3 = 'onboarding.steps.title3';
  static const String onboardingStepSubtitle3 = 'onboarding.steps.subtitle3';

  // Validation
  static const String validationRequired = 'validation.required';
  static const String validationFieldRequired = 'validation.field_required';

  // Home
  static const String homeTitle = 'home.title';
  static const String homeWelcome = 'home.welcome';
  static const String homeSubtitle = 'home.subtitle';

  // Auth - General
  static const String authOrContinueWith = 'auth.or_continue_with';

  // Auth - Login
  static const String authLoginTitle = 'auth.login.title';
  static const String authLoginSubtitle = 'auth.login.subtitle';
  static const String authLoginWelcomeBack = 'auth.login.welcome_back';
  static const String authLoginEmail = 'auth.login.email';
  static const String authLoginEmailHint = 'auth.login.email_hint';
  static const String authLoginEmailRequired = 'auth.login.email_required';
  static const String authLoginEmailInvalid = 'auth.login.email_invalid';
  static const String authLoginPassword = 'auth.login.password';
  static const String authLoginPasswordHint = 'auth.login.password_hint';
  static const String authLoginPasswordRequired =
      'auth.login.password_required';
  static const String authLoginPasswordMinLength =
      'auth.login.password_min_length';
  static const String authLoginRememberMe = 'auth.login.remember_me';
  static const String authLoginForgotPassword = 'auth.login.forgot_password';
  static const String authLoginButton = 'auth.login.button';
  static const String authLoginDontHaveAccount = 'auth.login.dont_have_account';
  static const String authLoginSignUp = 'auth.login.sign_up';

  // Auth - Signup
  static const String authSignupTitle = 'auth.signup.title';
  static const String authSignupSubtitle = 'auth.signup.subtitle';
  static const String authSignupName = 'auth.signup.name';
  static const String authSignupNameRequired = 'auth.signup.name_required';
  static const String authSignupConfirmPassword =
      'auth.signup.confirm_password';
  static const String authSignupConfirmPasswordRequired =
      'auth.signup.confirm_password_required';
  static const String authSignupPasswordsDoNotMatch =
      'auth.signup.passwords_do_not_match';
  static const String authSignupButton = 'auth.signup.button';
  static const String authSignupAlreadyHaveAccount =
      'auth.signup.already_have_account';
  static const String authSignupSignIn = 'auth.signup.sign_in';

  // Auth - Forgot Password
  static const String authForgotPasswordTitle = 'auth.forgot_password.title';
  static const String authForgotPasswordSubtitle =
      'auth.forgot_password.subtitle';
  static const String authForgotPasswordHelper = 'auth.forgot_password.helper';
  static const String authForgotPasswordResetLinkSent =
      'auth.forgot_password.reset_link_sent';
  static const String authForgotPasswordSubmit = 'auth.forgot_password.submit';

  // Auth - Terms
  static const String authTermsFirstPart = 'auth.terms.first_part';
  static const String authTermsLink = 'auth.terms.link';
  static const String authTermsSecondPart = 'auth.terms.second_part';
}
