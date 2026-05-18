import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/colors/app_colors.dart';
import '../../../../core/theme/typography/app_typography.dart';

class TermsAgreement extends StatelessWidget {
  const TermsAgreement({
    super.key,
    this.onRegisterTap,
  });

  final VoidCallback? onRegisterTap;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        style: AppTypography.regular12.copyWith(
          color: AppColors.grey3,
        ),
        children: [
          TextSpan(
            text: AppStrings.authTermsFirstPart.tr(),
          ),
          TextSpan(
            text: AppStrings.authTermsLink.tr(),
            style: AppTypography.regular12.copyWith(
              color: AppColors.primary,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primary,
            ),
            recognizer: TapGestureRecognizer()..onTap = onRegisterTap,
          ),
          TextSpan(
            text: AppStrings.authTermsSecondPart.tr(),
          ),
        ],
      ),
    );
  }
}
