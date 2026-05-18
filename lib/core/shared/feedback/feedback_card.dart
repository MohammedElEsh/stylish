import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/colors/app_colors.dart';
import '../../theme/typography/app_typography.dart';
import 'feedback_message.dart';

class FeedbackCard extends StatelessWidget {
  final FeedbackMessage message;
  final VoidCallback? onDismiss;

  const FeedbackCard({
    super.key,
    required this.message,
    this.onDismiss,
  });

  Color get _backgroundColor {
    switch (message.type) {
      case FeedbackType.success:
        return AppColors.success.withOpacity(0.12);
      case FeedbackType.error:
        return AppColors.error.withOpacity(0.12);
      case FeedbackType.info:
        return AppColors.fifth.withOpacity(0.12);
      case FeedbackType.warning:
        return AppColors.warning.withOpacity(0.12);
    }
  }

  Color get _borderColor {
    switch (message.type) {
      case FeedbackType.success:
        return AppColors.success;
      case FeedbackType.error:
        return AppColors.error;
      case FeedbackType.info:
        return AppColors.fifth;
      case FeedbackType.warning:
        return AppColors.warning;
    }
  }

  Color get _iconColor {
    switch (message.type) {
      case FeedbackType.success:
        return AppColors.success;
      case FeedbackType.error:
        return AppColors.error;
      case FeedbackType.info:
        return AppColors.fifth;
      case FeedbackType.warning:
        return AppColors.warning;
    }
  }

  IconData get _icon {
    switch (message.type) {
      case FeedbackType.success:
        return Icons.check_circle_outline;
      case FeedbackType.error:
        return Icons.error_outline;
      case FeedbackType.info:
        return Icons.info_outline;
      case FeedbackType.warning:
        return Icons.warning_amber_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: _borderColor.withOpacity(0.3), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(_icon, color: _iconColor, size: 20.r),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (message.title != null) ...[
                  Text(
                    message.title!,
                    style: AppTypography.semiBold14.copyWith(
                      color: _iconColor,
                    ),
                  ),
                  SizedBox(height: 2.h),
                ],
                Text(
                  message.description,
                  style: AppTypography.regular12.copyWith(
                    color: AppColors.grey1,
                  ),
                ),
              ],
            ),
          ),
          if (onDismiss != null)
            GestureDetector(
              onTap: onDismiss,
              child: Icon(
                Icons.close,
                size: 16.r,
                color: AppColors.grey3,
              ),
            ),
        ],
      ),
    );
  }
}
