import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/colors/app_colors.dart';
import '../../theme/typography/app_typography.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    // ── Content ─────────────────────────────
    this.controller,
    this.focusNode,
    this.initialValue,
    // ── Labels ──────────────────────────────
    this.hint,
    this.label,
    this.helper,
    this.externalError,
    // ── Prefix / Suffix ─────────────────────
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    // ── Password ────────────────────────────
    this.isPassword = false,
    this.passwordToggleIcon, // custom eye icon widget (overrides default)
    // ── Icon sizing & coloring ──────────────
    this.prefixIconSize, // size applied via IconTheme
    this.suffixIconSize, // size applied to suffixIcon & password eye
    this.prefixIconColor, // color applied via IconTheme
    this.suffixIconColor, // color applied to suffixIcon & password eye
    // ── Behaviour ───────────────────────────
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    // ── Keyboard ────────────────────────────
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    // ── Limits ──────────────────────────────
    this.maxLines = 1,
    this.minLines,
    this.maxLength, // enforced silently — no counter shown
    // ── Styling overrides ───────────────────
    this.fillColor,
    this.borderRadius,
    this.borderWidth, // stroke width for all borders
    this.contentPadding,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.errorStyle,
    this.helperStyle,
    this.textAlign = TextAlign.start,
    // ── Borders (full override if needed) ───
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.disabledBorder,
    // ── Callbacks ───────────────────────────
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onEditingComplete,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialValue;

  final String? hint;
  final String? label;
  final String? helper;
  final String? externalError;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;

  final bool isPassword;
  final Widget? passwordToggleIcon;

  final double? prefixIconSize;
  final double? suffixIconSize;
  final Color? prefixIconColor;
  final Color? suffixIconColor;

  final bool readOnly;
  final bool enabled;
  final bool autofocus;
  final bool autocorrect;
  final bool enableSuggestions;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;

  final int? maxLines;
  final int? minLines;
  final int? maxLength;

  final Color? fillColor;
  final double? borderRadius;
  final double? borderWidth;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? errorStyle;
  final TextStyle? helperStyle;
  final TextAlign textAlign;

  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;

  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;

  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword;
  }

  void _toggleObscure() => setState(() => _obscure = !_obscure);

  double get _r => widget.borderRadius ?? 12.r;

  double get _bw => widget.borderWidth ?? 1.0;

  InputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(_r),
        borderSide: BorderSide(color: color, width: _bw),
      );

  // Wraps any icon widget with IconTheme to enforce size / color without
  // breaking custom widgets like HugeIcon or SvgPicture.
  Widget _themed(Widget icon, {double? size, Color? color}) {
    if (size == null && color == null) return icon;
    return IconTheme(
      data: IconThemeData(size: size, color: color),
      child: icon,
    );
  }

  Widget? get _resolvedPrefixIcon {
    if (widget.prefixIcon == null) return null;
    return _themed(
      widget.prefixIcon!,
      size: widget.prefixIconSize,
      color: widget.prefixIconColor,
    );
  }

  Widget? get _resolvedSuffixIcon {
    if (widget.isPassword) {
      final eyeIcon = widget.passwordToggleIcon ??
          Icon(
            _obscure ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
            color: widget.suffixIconColor ?? AppColors.grey3,
            size: widget.suffixIconSize ?? 20.r,
          );
      return IconButton(icon: eyeIcon, onPressed: _toggleObscure);
    }
    if (widget.suffixIcon == null) return null;
    return _themed(
      widget.suffixIcon!,
      size: widget.suffixIconSize,
      color: widget.suffixIconColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      initialValue: widget.initialValue,
      obscureText: _obscure,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.inputFormatters,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      textAlign: widget.textAlign,
      style: widget.textStyle ?? AppTypography.regular12,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      decoration: InputDecoration(
        hintText: widget.hint,
        labelText: widget.label,
        helperText: widget.helper,
        errorText: widget.externalError,
        prefixIcon: _resolvedPrefixIcon,
        suffixIcon: _resolvedSuffixIcon,
        prefix: widget.prefix,
        suffix: widget.suffix,
        filled: true,
        fillColor: widget.enabled
            ? (widget.fillColor ?? AppColors.grey5)
            : AppColors.grey5,
        counterText: '',
        contentPadding: widget.contentPadding ??
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        hintStyle: widget.hintStyle ??
            AppTypography.regular12.copyWith(color: AppColors.grey2),
        labelStyle: widget.labelStyle,
        errorStyle: widget.errorStyle,
        helperStyle: widget.helperStyle,
        border: _border(AppColors.grey5),
        enabledBorder: widget.enabledBorder ?? _border(AppColors.grey3),
        focusedBorder: widget.focusedBorder ?? _border(AppColors.grey3),
        errorBorder: widget.errorBorder ?? _border(AppColors.error),
        focusedErrorBorder: widget.errorBorder ?? _border(AppColors.error),
        disabledBorder: widget.disabledBorder ?? _border(AppColors.grey5),
        prefixIconConstraints: widget.prefixIconConstraints,
        suffixIconConstraints: widget.suffixIconConstraints,
      ),
    );
  }
}
