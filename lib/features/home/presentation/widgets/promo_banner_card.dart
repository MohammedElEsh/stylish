import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/shared/buttons/app_button.dart';
import '../../../../core/theme/typography/app_typography.dart';

class PromoBannerCard extends StatelessWidget {
  const PromoBannerCard({
    super.key,
    this.onTap,
    this.borderRadius,
  });

  final VoidCallback? onTap;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? 16.r;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              AppAssets.homeSalesBanner,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.homePromoDiscount.tr(),
                    style: AppTypography.bold28.copyWith(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    AppStrings.homePromoSubtitle.tr(),
                    style:
                        AppTypography.regular14.copyWith(color: Colors.white),
                  ),
                  Text(
                    AppStrings.homePromoColours.tr(),
                    style:
                        AppTypography.regular14.copyWith(color: Colors.white),
                  ),
                  SizedBox(height: 12.h),
                  AppButton(
                    label: AppStrings.homePromoShopNow.tr(),
                    onPressed: onTap,
                    variant: AppButtonVariant.outlined,
                    expanded: false,
                    suffixIcon: HugeIcon(
                      icon: HugeIcons.strokeRoundedArrowRight01,
                      size: 14.r,
                      color: Colors.white,
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
