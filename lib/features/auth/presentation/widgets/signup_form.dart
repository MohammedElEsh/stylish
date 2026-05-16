import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared/inputs/app_text_field.dart';
import '../../../../core/theme/colors/app_colors.dart';
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
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(
              CupertinoIcons.lock_fill,
              color: AppColors.grey3,
            ),
            validator: AppValidators.validatePassword,
          ),
          SizedBox(height: 16.h),
          AppTextField(
            controller: confirmPasswordController,
            hint: 'auth.confirm_password'.tr(),
            isPassword: true,
            textInputAction: TextInputAction.done,
            prefixIcon: const Icon(
              CupertinoIcons.lock_fill,
              color: AppColors.grey3,
            ),
            validator: AppValidators.validatePassword,
          ),
        ],
      ),
    );
  }
}
