import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:stylish/features/home/presentation/widgets/action_chip.dart';

import '../../../../core/constants/app_strings.dart';

class FilterSortRow extends StatelessWidget {
  const FilterSortRow({
    super.key,
    this.title,
    this.onSortTap,
    this.onFilterTap,
  });

  final String? title;
  final VoidCallback? onSortTap;
  final VoidCallback? onFilterTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            title ?? AppStrings.homeFilterSortTitle.tr(),
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        HomeActionChip(
          label: AppStrings.homeFilterSortSort.tr(),
          icon: HugeIcons.strokeRoundedArrowUpDown,
          onTap: onSortTap,
        ),
        SizedBox(width: 8.w),
        HomeActionChip(
          label: AppStrings.homeFilterSortFilter.tr(),
          icon: HugeIcons.strokeRoundedFilter,
          onTap: onFilterTap,
        ),
      ],
    );
  }
}
