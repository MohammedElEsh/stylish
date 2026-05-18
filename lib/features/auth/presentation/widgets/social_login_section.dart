import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/features/auth/presentation/widgets/social_login_button.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/colors/app_colors.dart';
import '../../../../core/theme/typography/app_typography.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({
    super.key,
    required this.onGoogle,
    required this.onApple,
    required this.onFacebook,
  });

  final VoidCallback onGoogle;
  final VoidCallback onApple;
  final VoidCallback onFacebook;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider(color: AppColors.grey5)),
            Text(AppStrings.authOrContinueWith.tr(),
                style: AppTypography.regular12),
            const Expanded(child: Divider(color: AppColors.grey5)),
          ],
        ),
        SizedBox(height: 24.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialButton(asset: AppAssets.googleIcon, onPressed: onGoogle),
            SizedBox(width: 16.w),
            SocialButton(asset: AppAssets.appleIcon, onPressed: onApple),
            SizedBox(width: 16.w),
            SocialButton(asset: AppAssets.facebookIcon, onPressed: onFacebook),
          ],
        ),
      ],
    );
  }
}
