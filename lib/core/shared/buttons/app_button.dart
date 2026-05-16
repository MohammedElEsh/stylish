import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/colors/app_colors.dart';
import '../../theme/typography/app_typography.dart';

enum AppButtonVariant { primary, secondary, outline, ghost, danger }

enum AppButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    // ── Required ────────────────────────────
    required this.label,
    required this.onPressed,
    // ── Variant & Size ──────────────────────
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.large,
    // ── State ───────────────────────────────
    this.isLoading = false,
    this.enabled = true,
    // ── Icons ───────────────────────────────
    this.prefixIcon, // any Widget — Icon, SvgPicture, HugeIcon …
    this.suffixIcon,
    this.iconSpacing, // gap between icon and label (default 8.w)
    this.iconSize, // applied via IconTheme to prefix & suffix
    this.iconColor, // applied via IconTheme to prefix & suffix
    // ── Size overrides ──────────────────────
    this.width, // explicit width; ignored when expanded = true
    this.height, // overrides size preset
    this.expanded = true, // false → shrinks to content width
    this.borderRadius, // overrides size preset
    this.padding, // overrides size preset
    // ── Style overrides ─────────────────────
    this.backgroundColor,
    this.foregroundColor, // text + icon tint
    this.borderColor,
    this.borderWidth, // border stroke width (default 1)
    this.textStyle, // fully overrides label TextStyle
    this.elevation,
    this.shadowColor,
    // ── Loading ─────────────────────────────
    this.loadingIndicator, // custom loading widget
    this.loadingColor, // color of the default CircularProgressIndicator
  });

  final String label;
  final VoidCallback onPressed;

  final AppButtonVariant variant;
  final AppButtonSize size;

  final bool isLoading;
  final bool enabled;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? iconSpacing;
  final double? iconSize;
  final Color? iconColor;

  final double? width;
  final double? height;
  final bool expanded;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final TextStyle? textStyle;
  final double? elevation;
  final Color? shadowColor;

  final Widget? loadingIndicator;
  final Color? loadingColor;

  // ── Resolved size values ────────────────────────────────────────

  double get _height =>
      height ??
      switch (size) {
        AppButtonSize.small => 36.h,
        AppButtonSize.medium => 46.h,
        AppButtonSize.large => 56.h,
      };

  double get _radius =>
      borderRadius ??
      switch (size) {
        AppButtonSize.small => 8.r,
        AppButtonSize.medium => 10.r,
        AppButtonSize.large => 12.r,
      };

  EdgeInsetsGeometry get _padding =>
      padding ??
      switch (size) {
        AppButtonSize.small => EdgeInsets.symmetric(horizontal: 12.w),
        AppButtonSize.medium => EdgeInsets.symmetric(horizontal: 20.w),
        AppButtonSize.large => EdgeInsets.symmetric(horizontal: 24.w),
      };

  TextStyle get _textStyle => textStyle ?? AppTypography.semiBold20;

  // ── Resolved color values ────────────────────────────────────────

  Color get _bg =>
      backgroundColor ??
      switch (variant) {
        AppButtonVariant.primary => AppColors.primary,
        AppButtonVariant.secondary => AppColors.primary.withOpacity(.12),
        AppButtonVariant.outline => Colors.transparent,
        AppButtonVariant.ghost => Colors.transparent,
        AppButtonVariant.danger => AppColors.error,
      };

  Color get _fg =>
      foregroundColor ??
      switch (variant) {
        AppButtonVariant.primary => Colors.white,
        AppButtonVariant.secondary => AppColors.primary,
        AppButtonVariant.outline => AppColors.primary,
        AppButtonVariant.ghost => AppColors.primary,
        AppButtonVariant.danger => Colors.white,
      };

  Color? get _border =>
      borderColor ??
      switch (variant) {
        AppButtonVariant.outline => AppColors.primary,
        _ => null,
      };

  bool get _isDisabled => !enabled || isLoading;

  // ── Build ────────────────────────────────────────────────────────

  Widget _wrapIcon(Widget icon) {
    if (iconSize == null && iconColor == null) return icon;
    return IconTheme(
      data: IconThemeData(size: iconSize, color: iconColor),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final gap = iconSpacing ?? 8.w;

    final child = isLoading
        ? loadingIndicator ??
            SizedBox(
              width: 20.r,
              height: 20.r,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: loadingColor ?? _fg,
              ),
            )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (prefixIcon != null) ...[
                _wrapIcon(prefixIcon!),
                SizedBox(width: gap),
              ],
              Text(label, style: _textStyle.copyWith(color: _fg)),
              if (suffixIcon != null) ...[
                SizedBox(width: gap),
                _wrapIcon(suffixIcon!),
              ],
            ],
          );

    return SizedBox(
      width: expanded ? (width ?? double.infinity) : width,
      height: _height,
      child: ElevatedButton(
        onPressed: _isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _bg,
          foregroundColor: _fg,
          disabledBackgroundColor: AppColors.grey5,
          disabledForegroundColor: AppColors.grey3,
          elevation: elevation ?? 0,
          shadowColor: shadowColor ?? Colors.transparent,
          padding: _padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radius),
            side: _border != null && !_isDisabled
                ? BorderSide(color: _border!, width: borderWidth ?? 1)
                : BorderSide.none,
          ),
        ),
        child: child,
      ),
    );
  }
}
