import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared/inputs/app_text_field.dart';
import '../../../../core/theme/colors/app_colors.dart';
import '../../../../core/theme/typography/app_typography.dart';
import '../../../../core/validators/app_validators.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onForgotPassword,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onForgotPassword;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            controller: emailController,
            hint: 'auth.email_hint'.tr(),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(
              CupertinoIcons.person_fill,
              color: AppColors.grey3,
            ),
            validator: AppValidators.validateEmail,
          ),
          SizedBox(height: 16.h),
          AppTextField(
            controller: passwordController,
            hint: 'auth.password_hint'.tr(),
            isPassword: true,
            textInputAction: TextInputAction.done,
            prefixIcon: const Icon(
              CupertinoIcons.lock_fill,
              color: AppColors.grey3,
            ),
            validator: AppValidators.validatePassword,
          ),
          SizedBox(height: 4.h),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: onForgotPassword,
              child: Text(
                'auth.forgot_password'.tr(),
                style: AppTypography.semiBold14.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
