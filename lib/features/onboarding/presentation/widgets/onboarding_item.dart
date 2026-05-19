import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                image,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            title,
            style: theme.textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          Text(
            description,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
