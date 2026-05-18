import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/shared/inputs/app_text_field.dart';
import '../../../../core/theme/colors/app_colors.dart';
import '../../../../core/theme/typography/app_typography.dart';
import '../../../../core/validators/app_validators.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({
    super.key,
    required this.formKey,
    required this.emailController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            controller: emailController,
            hint: AppStrings.authLoginEmailHint.tr(),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            prefixIcon: const Icon(
              CupertinoIcons.mail_solid,
              color: AppColors.grey3,
            ),
            validator: AppValidators.validateEmail,
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.only(right: 50.w),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '* ',
                    style: AppTypography.regular12.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  TextSpan(
                    text: AppStrings.authForgotPasswordHelper.tr(),
                    style: AppTypography.regular12.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
