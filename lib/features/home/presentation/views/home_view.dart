import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared/inputs/search_field.dart';
import '../../../../core/shared/layout/app_top_bar.dart';
import '../../../categories/presentation/widgets/categories_list.dart';
import '../manager/home_cubit.dart';
import '../manager/home_state.dart';
import '../widgets/filter_sort_row.dart';

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
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 8.h,
            ),
            child: Column(
              children: [
                const SearchField(),
                SizedBox(height: 16.h),
                const FilterSortRow(),
                SizedBox(height: 24.h),
                const CategoriesList(),
              ],
            ),
          ),
        );
      },
    );
  }
}
