import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/colors/app_colors.dart';
import '../../../../core/theme/typography/app_typography.dart';

class OnboardingFooter extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  const OnboardingFooter({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!isFirst)
            TextButton(
              onPressed: onPrev,
              child: Text(
                'onboarding.prev'.tr(),
                style: AppTypography.semiBold18.copyWith(
                  color: AppColors.grey5,
                ),
              ),
            )
          else
            const SizedBox.shrink(),
          TextButton(
            onPressed: onNext,
            child: Text(
              isLast ? 'onboarding.get_started'.tr() : 'onboarding.next'.tr(),
              style: AppTypography.semiBold18.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
