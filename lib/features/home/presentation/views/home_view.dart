import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/shared/inputs/search_field.dart';
import '../../../../core/shared/layout/app_top_bar.dart';
import '../../../../core/theme/colors/app_colors.dart';
import '../../../categories/presentation/widgets/categories_list.dart';
import '../manager/home_cubit.dart';
import '../manager/home_state.dart';
import '../widgets/filter_sort_row.dart';
import '../widgets/promo_banner_carousel.dart';
import '../widgets/promotional_banner.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppTopBar(
            topPadding: 12.h,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 8.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SearchField(),
                SizedBox(height: 16.h),
                const FilterSortRow(),
                SizedBox(height: 24.h),
                const CategoriesList(),
                SizedBox(height: 16.h),
                const PromoBannerCarousel(),
                SizedBox(height: 16.h),
                PromotionalBanner(
                  title: AppStrings.homeDealOfTheDayTitle.tr(),
                  subtitle: AppStrings.homeDealOfTheDayRemaining.tr(),
                  subtitleIcon: HugeIcons.strokeRoundedClock01,
                  backgroundColor: AppColors.secondaryMedium,
                ),
                SizedBox(height: 16.h),
                PromotionalBanner(
                  title: AppStrings.homeTrendingProductsTitle.tr(),
                  subtitle: AppStrings.homeDealOfTheDayLastDate.tr(),
                  subtitleIcon: HugeIcons.strokeRoundedDateTime,
                  backgroundColor: AppColors.primaryMedium,
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
