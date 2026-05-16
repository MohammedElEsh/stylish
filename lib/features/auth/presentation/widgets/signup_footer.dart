import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stylish/core/theme/colors/app_colors.dart';

import '../../../../core/theme/typography/app_typography.dart';

class SignupFooter extends StatelessWidget {
  const SignupFooter({super.key, required this.onSignIn});

  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'auth.already_have_account'.tr(),
          style: AppTypography.regular14.copyWith(
            color: AppColors.grey2,
          ),
        ),
        TextButton(
          onPressed: onSignIn,
          child: Text(
            'auth.sign_in'.tr(),
            style: AppTypography.semiBold14.copyWith(
              color: AppColors.primary,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primary,
              decorationThickness: 1.5,
              decorationStyle: TextDecorationStyle.solid,
            ),
          ),
        ),
      ],
    );
  }
}
