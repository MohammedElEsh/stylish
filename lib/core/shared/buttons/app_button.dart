import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Visual variant of [AppButton]. Each variant pulls its base style from
/// the matching Material button theme, so global theming stays centralized
/// in the [ThemeData] definitions (see `light_theme.dart` / `dark_theme.dart`).
///
/// The optional [AppButton.style] parameter is always merged on top of the
/// resolved base style, so a single override can recolor / resize / restyle
/// any variant without duplicating its base look.
enum AppButtonVariant {
  /// Solid background. Resolves to `theme.elevatedButtonTheme.style`.
  filled,

  /// Transparent background with a colored border.
  /// Resolves to `theme.outlinedButtonTheme.style`.
  outlined,

  /// No background, no border. Resolves to `theme.textButtonTheme.style`.
  text,
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,

    // required
    required this.label,
    required this.onPressed,

    // variant
    this.variant = AppButtonVariant.filled,

    // states
    this.isLoading = false,
    this.enabled = true,

    // icons
    this.prefixIcon,
    this.suffixIcon,

    // layout
    this.expanded = true,
    this.alignment = Alignment.center,

    // sizing
    this.width,
    this.height,
    this.minSize,
    this.maxSize,

    // theme override (safe escape hatch)
    this.style,

    // feedback
    this.autofocus = false,
    this.focusNode,
    this.onLongPress,
    this.onHover,

    // semantics / accessibility
    this.semanticLabel,

    // splash / interaction
    this.enableFeedback = true,
    this.enableHaptic = false,

    // clip behavior
    this.clipBehavior = Clip.none,
  });

  final String label;
  final VoidCallback? onPressed;

  final AppButtonVariant variant;

  final bool isLoading;
  final bool enabled;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final bool expanded;
  final Alignment alignment;

  final double? width;
  final double? height;

  final Size? minSize;
  final Size? maxSize;

  final ButtonStyle? style;

  final bool autofocus;
  final FocusNode? focusNode;

  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;

  final String? semanticLabel;

  final bool enableFeedback;
  final bool enableHaptic;

  final Clip clipBehavior;

  bool get _disabled => isLoading || onPressed == null || !enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final baseStyle = _resolveBaseStyle(theme);
    final resolvedStyle = baseStyle?.merge(style);

    final fg = resolvedStyle?.foregroundColor?.resolve({}) ??
        _resolveFallbackFg(theme);

    final child = _buildChild(fg);

    return SizedBox(
      width: width ?? (expanded ? double.infinity : null),
      height: height,
      child: _buildButton(
        onPressed: _disabled ? null : onPressed,
        onLongPress: onLongPress,
        onHover: onHover,
        autofocus: autofocus,
        focusNode: focusNode,
        style: resolvedStyle,
        clipBehavior: clipBehavior,
        child: Semantics(
          label: semanticLabel,
          button: true,
          child: child,
        ),
      ),
    );
  }

  // ── Variant resolution ────────────────────────────────────────────────────
  // Single source of truth: each variant maps to one Material button theme
  // and one underlying widget. Adding a new variant is a 3-line change.

  ButtonStyle? _resolveBaseStyle(ThemeData theme) {
    switch (variant) {
      case AppButtonVariant.filled:
        return theme.elevatedButtonTheme.style;
      case AppButtonVariant.outlined:
        return theme.outlinedButtonTheme.style;
      case AppButtonVariant.text:
        return theme.textButtonTheme.style;
    }
  }

  Color _resolveFallbackFg(ThemeData theme) {
    switch (variant) {
      case AppButtonVariant.filled:
        return theme.colorScheme.onPrimary;
      case AppButtonVariant.outlined:
      case AppButtonVariant.text:
        return theme.colorScheme.primary;
    }
  }

  Widget _buildButton({
    required VoidCallback? onPressed,
    required VoidCallback? onLongPress,
    required ValueChanged<bool>? onHover,
    required bool autofocus,
    required FocusNode? focusNode,
    required ButtonStyle? style,
    required Clip clipBehavior,
    required Widget child,
  }) {
    switch (variant) {
      case AppButtonVariant.filled:
        return ElevatedButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHover: onHover,
          autofocus: autofocus,
          focusNode: focusNode,
          style: style,
          clipBehavior: clipBehavior,
          child: child,
        );
      case AppButtonVariant.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHover: onHover,
          autofocus: autofocus,
          focusNode: focusNode,
          style: style,
          clipBehavior: clipBehavior,
          child: child,
        );
      case AppButtonVariant.text:
        return TextButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHover: onHover,
          autofocus: autofocus,
          focusNode: focusNode,
          style: style,
          clipBehavior: clipBehavior,
          child: child,
        );
    }
  }

  Widget _buildChild(Color fg) {
    if (isLoading) {
      return SizedBox(
        width: 18.r,
        height: 18.r,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: fg,
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) ...[
          IconTheme(data: IconThemeData(color: fg), child: prefixIcon!),
          SizedBox(width: 8.w),
        ],
        Text(label, style: TextStyle(color: fg)),
        if (suffixIcon != null) ...[
          SizedBox(width: 8.w),
          IconTheme(data: IconThemeData(color: fg), child: suffixIcon!),
        ],
      ],
    );
  }
}
