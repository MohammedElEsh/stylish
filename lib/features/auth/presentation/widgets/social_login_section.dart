import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/features/auth/presentation/widgets/social_login_button.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';

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
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(AppStrings.authOrContinueWith.tr(),
                  style: theme.textTheme.labelMedium),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        SizedBox(height: 24.w),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16.w,
          runSpacing: 8.w,
          children: [
            SocialButton(asset: AppAssets.googleIcon, onPressed: onGoogle),
            SocialButton(asset: AppAssets.appleIcon, onPressed: onApple),
            SocialButton(asset: AppAssets.facebookIcon, onPressed: onFacebook),
          ],
        ),
      ],
    );
  }
}
