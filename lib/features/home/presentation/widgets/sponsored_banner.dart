import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/typography/app_typography.dart';

class SponsoredBanner extends StatelessWidget {
  const SponsoredBanner({
    super.key,
    this.header,
    this.title,
    this.bannerImage = AppAssets.homeSponsored,
    this.borderRadius,
    this.onTap,
  });

  final String? header;
  final String? title;
  final String bannerImage;
  final double? borderRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final radius = borderRadius ?? 16.r;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 4.w, bottom: 8.h),
          child: Text(
            header ?? AppStrings.homeSponsoredHeader.tr(),
            style: AppTypography.semiBold20,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Material(
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
                  aspectRatio: 343 / 280,
                  child: Image.asset(
                    bannerImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title ?? AppStrings.homeSponsoredTitle.tr(),
                          style: AppTypography.semiBold18,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedArrowRight01,
                        size: 18.r,
                        color: colors.onSurface,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
