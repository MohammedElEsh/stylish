import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/shared/buttons/app_button.dart';
import '../../../../core/theme/typography/app_typography.dart';

/// A horizontal, full-width, colored section header banner.
///
/// Generic by design — the caller supplies every visual and semantic value
/// (title, subtitle, icons, background color, action label, callbacks).
///
/// Two layouts are supported, selected by whether [subtitle] is provided:
///
/// * **No subtitle** — `[icon?] [Title]` on the left. Used for compact
///   "Trending Products", "New Arrivals", etc. headers.
/// * **With subtitle** — title on top, `[icon?] [Subtitle]` below. Used for
///   "Deal of the Day" style headers with a secondary line (countdown, count,
///   helper text, ...).
///
/// The right side always renders an outlined action button with a right-arrow
/// suffix. Its label defaults to a localized "View all" but can be overridden
/// via [actionLabel]. Tapping the banner background triggers the same
/// [onActionTap] callback.
class PromotionalBanner extends StatelessWidget {
  const PromotionalBanner({
    super.key,

    // content
    required this.title,
    this.subtitle,
    this.leadingIcon,
    this.subtitleIcon,

    // visuals
    required this.backgroundColor,
    this.foregroundColor = Colors.white,
    this.borderRadius,

    // action
    this.actionLabel,
    this.onActionTap,
  });

  /// Main title (e.g. "Trending Products", "Deal of the Day").
  final String title;

  /// Optional secondary line. When non-null, the layout switches to the
  /// vertical (title on top, subtitle below) arrangement.
  final String? subtitle;

  /// Optional icon shown BEFORE [title] in the horizontal layout
  /// (no-subtitle mode). Ignored when [subtitle] is provided.
  final List<List<dynamic>>? leadingIcon;

  /// Optional icon shown BEFORE [subtitle] in the vertical layout
  /// (subtitle mode). Ignored when [subtitle] is null.
  final List<List<dynamic>>? subtitleIcon;

  /// Banner background color. Required so callers intentionally pick the
  /// section's brand color rather than inheriting a surprise default.
  final Color backgroundColor;

  /// Color applied to the title, subtitle, icons, and the outlined action
  /// button's border/text. Defaults to white — the common case for a colored
  /// background.
  final Color foregroundColor;

  /// Corner radius. Defaults to `12.r` to match the rest of the design system.
  final double? borderRadius;

  /// Label of the outlined action button. Defaults to a localized "View all".
  final String? actionLabel;

  /// Callback fired when the action button is pressed, or when the banner
  /// background is tapped. Optional — leave null to render a non-interactive
  /// banner.
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? 12.r;
    final hasSubtitle = subtitle != null;

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onActionTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              Expanded(
                child: hasSubtitle
                    ? _buildVerticalLayout()
                    : _buildHorizontalLayout(),
              ),
              SizedBox(width: 12.w),
              _buildActionButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalLayout() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leadingIcon != null) ...[
          HugeIcon(
            icon: leadingIcon!,
            size: 18.r,
            color: foregroundColor,
          ),
          SizedBox(width: 8.w),
        ],
        Flexible(
          child: Text(
            title,
            style: AppTypography.semiBold18.copyWith(color: foregroundColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: AppTypography.semiBold18.copyWith(color: foregroundColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            if (subtitleIcon != null) ...[
              HugeIcon(
                icon: subtitleIcon!,
                size: 14.r,
                color: foregroundColor,
              ),
              SizedBox(width: 6.w),
            ],
            Flexible(
              child: Text(
                subtitle!,
                style: AppTypography.regular12.copyWith(color: foregroundColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    return AppButton(
      label: actionLabel ?? AppStrings.homeSectionViewAll.tr(),
      onPressed: onActionTap,
      variant: AppButtonVariant.outlined,
      expanded: false,
      suffixIcon: HugeIcon(
        icon: HugeIcons.strokeRoundedArrowRight01,
        size: 14.r,
        color: foregroundColor,
      ),
    );
  }
}
