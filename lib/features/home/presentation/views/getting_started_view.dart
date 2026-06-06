import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/theme/typography/app_typography.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/session/session_manager.dart';
import '../../../../core/shared/buttons/app_button.dart';

class GettingStartedView extends StatelessWidget {
  const GettingStartedView({super.key});

  void _onGetStarted(BuildContext context) {
    // No manual navigation: the state transition drives the redirect.
    sl<SessionManager>().markReady();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppAssets.gettingStarted,
            fit: BoxFit.cover,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.15),
                  Colors.black.withOpacity(0.65),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 32.h,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppStrings.gettingStartedTitle.tr(),
                    textAlign: TextAlign.center,
                    style: AppTypography.bold28.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    AppStrings.gettingStartedSubtitle.tr(),
                    textAlign: TextAlign.center,
                    style: AppTypography.regular14.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  AppButton(
                    variant: AppButtonVariant.elevated,
                    label: AppStrings.gettingStartedButton.tr(),
                    onPressed: () => _onGetStarted(context),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
