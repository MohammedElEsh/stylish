import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/shared/inputs/app_text_field.dart';
import '../../../../core/validators/app_validators.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            controller: emailController,
            hint: AppStrings.authLoginEmailHint.tr(),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            prefixIcon: Icon(
              CupertinoIcons.person_fill,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            validator: AppValidators.validateEmail,
          ),
          SizedBox(height: 16.h),
          AppTextField(
            controller: passwordController,
            hint: AppStrings.authLoginPasswordHint.tr(),
            isPassword: true,
            textInputAction: TextInputAction.next,
            prefixIcon: Icon(
              CupertinoIcons.lock_fill,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            validator: AppValidators.validatePassword,
          ),
          SizedBox(height: 16.h),
          AppTextField(
            controller: confirmPasswordController,
            hint: AppStrings.authSignupConfirmPassword.tr(),
            isPassword: true,
            textInputAction: TextInputAction.done,
            prefixIcon: Icon(
              CupertinoIcons.lock_fill,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            validator: AppValidators.validatePassword,
          ),
        ],
      ),
    );
  }
}
