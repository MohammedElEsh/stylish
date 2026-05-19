import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/shared/buttons/app_button.dart';
import '../widgets/signup_footer.dart';
import '../widgets/signup_form.dart';
import '../widgets/social_login_section.dart';
import '../widgets/terms_agreement.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _onSignUp() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement signup logic
    }
  }

  void _onSignIn() => context.push(RouteNames.login);

  void _onSocialLogin() {
    // TODO: Implement social login
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 32.h),
              Text(
                AppStrings.authSignupTitle.tr(),
                textAlign: TextAlign.left,
                style: theme.textTheme.displayLarge,
              ),
              SizedBox(height: 32.h),
              SignupForm(
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
              ),
              SizedBox(height: 24.h),
              TermsAgreement(
                onRegisterTap: () {},
              ),
              SizedBox(height: 24.h),
              AppButton(
                label: AppStrings.authSignupButton.tr(),
                onPressed: _onSignUp,
              ),
              SizedBox(height: 48.h),
              SocialLoginSection(
                onGoogle: _onSocialLogin,
                onApple: _onSocialLogin,
                onFacebook: _onSocialLogin,
              ),
              SizedBox(height: 32.h),
              SignupFooter(
                onSignIn: _onSignIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
