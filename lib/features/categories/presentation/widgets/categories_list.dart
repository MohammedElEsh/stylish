import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../data/models/category_model.dart';
import '../manager/categories_cubit.dart';
import '../manager/categories_state.dart';
import 'category_item.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
    this.itemSize = 60,
    this.onCategoryTap,
  });

  final double itemSize;
  final ValueChanged<int>? onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesError) {
          return const SizedBox.shrink();
        }

        final isLoading = state is! CategoriesLoaded;
        final categories = state is CategoriesLoaded
            ? state.categories
            : const <CategoryModel>[];

        final itemCount = isLoading ? 10 : categories.length;

        return Skeletonizer(
          enabled: isLoading,
          enableSwitchAnimation: true,
          child: SizedBox(
            height: (itemSize + 36).h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: itemCount,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                if (isLoading) {
                  return SizedBox(
                    width: (itemSize + 12).w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Bone.circle(size: itemSize.r),
                        SizedBox(height: 8.h),
                        Bone.text(
                          fontSize: 12.sp,
                          width: (itemSize * 0.7).w,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ],
                    ),
                  );
                }
                final category = categories[index];
                return CategoryItem(
                  name: category.name,
                  imageUrl: category.image,
                  size: itemSize,
                  onTap: () => onCategoryTap?.call(index),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
