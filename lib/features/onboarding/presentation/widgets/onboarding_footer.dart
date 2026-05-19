import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_strings.dart';

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
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!isFirst)
            TextButton(
              onPressed: onPrev,
              child: Text(
                AppStrings.onboardingPrev.tr(),
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.outlineVariant,
                ),
              ),
            )
          else
            const SizedBox.shrink(),
          TextButton(
            onPressed: onNext,
            child: Text(
              isLast
                  ? AppStrings.onboardingGetStarted.tr()
                  : AppStrings.onboardingNext.tr(),
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
