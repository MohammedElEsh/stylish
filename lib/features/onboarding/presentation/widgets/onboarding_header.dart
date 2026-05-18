import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/colors/app_colors.dart';
import '../../../../core/theme/typography/app_typography.dart';

class OnboardingHeader extends StatelessWidget {
  final int current;
  final int total;
  final bool showSkip;
  final VoidCallback? onSkip;

  const OnboardingHeader({
    super.key,
    required this.current,
    required this.total,
    required this.showSkip,
    this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 22.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$current/$total',
            style: AppTypography.semiBold18.copyWith(
              color: AppColors.primary,
            ),
          ),
          if (showSkip)
            InkWell(
              onTap: onSkip,
              child: Text(
                AppStrings.onboardingSkip.tr(),
                style: AppTypography.semiBold18,
              ),
            ),
        ],
      ),
    );
  }
}
