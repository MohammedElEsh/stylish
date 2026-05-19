import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_strings.dart';
import '../../extensions/context_extensions.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.error,
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off, size: 16.r, color: context.colorScheme.onError),
          SizedBox(width: 8.w),
          Text(
            AppStrings.sharedNoInternet.tr(),
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colorScheme.onError,
            ),
          ),
        ],
      ),
    );
  }
}
