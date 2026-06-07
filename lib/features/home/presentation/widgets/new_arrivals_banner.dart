import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/shared/buttons/app_button.dart';
import '../../../../core/theme/typography/app_typography.dart';

class NewArrivalsBanner extends StatelessWidget {
  const NewArrivalsBanner({
    super.key,
    this.title,
    this.subtitle,
    this.bannerImage = AppAssets.homeSummerSale,
    this.borderRadius,
    this.onTap,
    this.onViewAllTap,
  });

  final String? title;
  final String? subtitle;
  final String bannerImage;
  final double? borderRadius;
  final VoidCallback? onTap;
  final VoidCallback? onViewAllTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final radius = borderRadius ?? 16.r;

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 343 / 165,
              child: Image.asset(
                bannerImage,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title ?? AppStrings.homeNewArrivalsTitle.tr(),
                          style: AppTypography.semiBold20,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          subtitle ?? AppStrings.homeNewArrivalsSubtitle.tr(),
                          style: AppTypography.regular14.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  AppButton(
                    label: AppStrings.homeSectionViewAll.tr(),
                    onPressed: () {},
                    variant: AppButtonVariant.elevated,
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
