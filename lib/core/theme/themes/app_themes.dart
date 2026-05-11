import 'package:flutter/material.dart';
import '../colors/app_colors.dart';
import '../typography/app_typography.dart';

class AppThemes {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.backgroundLight,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surfaceLight,
          error: AppColors.error,
        ),
        textTheme: TextTheme(
          displayLarge: AppTypography.h1,
          displayMedium: AppTypography.h2,
          displaySmall: AppTypography.h3,
          bodyLarge: AppTypography.bodyLarge,
          bodyMedium: AppTypography.bodyMedium,
          bodySmall: AppTypography.bodySmall,
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surfaceDark,
          error: AppColors.error,
        ),
        textTheme: TextTheme(
          displayLarge: AppTypography.h1.copyWith(color: AppColors.textPrimaryDark),
          displayMedium: AppTypography.h2.copyWith(color: AppColors.textPrimaryDark),
          displaySmall: AppTypography.h3.copyWith(color: AppColors.textPrimaryDark),
          bodyLarge: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimaryDark),
          bodyMedium: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimaryDark),
          bodySmall: AppTypography.bodySmall.copyWith(color: AppColors.textPrimaryDark),
        ),
      );
}