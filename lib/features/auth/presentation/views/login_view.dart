import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/shared/buttons/app_button.dart';
import '../../../../core/theme/colors/app_colors.dart';
import '../../../../core/theme/typography/app_typography.dart';
import '../widgets/login_footer.dart';
import '../widgets/login_form.dart';
import '../widgets/social_login_section.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement login logic
    }
  }

  void _onForgotPassword() => context.push(RouteNames.forgotPassword);

  void _onSignUp() => context.push(RouteNames.signup);

  void _onSocialLogin() {
    // TODO: Implement social login
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 32.w),
              Text(
                AppStrings.authLoginWelcomeBack.tr(),
                textAlign: TextAlign.left,
                style: AppTypography.bold36,
              ),
              SizedBox(height: 32.w),
              LoginForm(
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController,
                onForgotPassword: _onForgotPassword,
              ),
              SizedBox(height: 24.w),
              AppButton(
                label: AppStrings.authLoginButton.tr(),
                onPressed: _onLogin,
              ),
              SizedBox(height: 96.h),
              SocialLoginSection(
                onGoogle: _onSocialLogin,
                onApple: _onSocialLogin,
                onFacebook: _onSocialLogin,
              ),
              SizedBox(height: 32.h),
              LoginFooter(onSignUp: _onSignUp),
            ],
          ),
        ),
      ),
    );
  }
}
