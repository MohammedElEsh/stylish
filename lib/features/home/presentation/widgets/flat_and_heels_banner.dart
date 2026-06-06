import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/shared/buttons/app_button.dart';
import '../../../../core/theme/typography/app_typography.dart';

class FlatAndHeelsBanner extends StatelessWidget {
  const FlatAndHeelsBanner({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return AspectRatio(
      aspectRatio: 343 / 172,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 150.w,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      AppAssets.homeGoldStars,
                      fit: BoxFit.contain,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: Image.asset(
                      AppAssets.homeGoldLine,
                      width: 14.w,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    left: 16.w,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      child: Image.asset(
                        AppAssets.homeWomanHeels,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.homeFlatAndHeelsTitle.tr(),
                    style: AppTypography.semiBold20,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    AppStrings.homeFlatAndHeelsSubtitle.tr(),
                    style: AppTypography.regular14,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 18.h),
                  AppButton(
                    variant: AppButtonVariant.elevated,
                    label: AppStrings.homeFlatAndHeelsButton.tr(),
                    onPressed: () {},
                    expanded: false,
                    suffixIcon: HugeIcon(
                      icon: HugeIcons.strokeRoundedArrowRight01,
                      size: 14.r,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
