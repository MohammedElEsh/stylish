import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({super.key, required this.asset, required this.onPressed});

  final String asset;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(16.w),
        side: BorderSide(color: theme.colorScheme.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
        ),
        backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
      ),
      child: SvgPicture.asset(asset, width: 24.w, height: 24.w),
    );
  }
}
