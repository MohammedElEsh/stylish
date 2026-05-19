import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,

    // required
    required this.label,
    required this.onPressed,

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

    // 👇 CORE: uses your elevatedButtonTheme exactly
    final baseStyle = theme.elevatedButtonTheme.style;

    final resolvedStyle = baseStyle?.merge(style);

    final fg = resolvedStyle?.foregroundColor?.resolve({}) ??
        theme.colorScheme.onPrimary;

    final child = _buildChild(fg);

    return SizedBox(
      width: width ?? (expanded ? double.infinity : null),
      height: height,
      child: ElevatedButton(
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
        Text(label),
        if (suffixIcon != null) ...[
          SizedBox(width: 8.w),
          IconTheme(data: IconThemeData(color: fg), child: suffixIcon!),
        ],
      ],
    );
  }
}
