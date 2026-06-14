import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../data/models/product_model.dart';
import '../manager/products_cubit.dart';
import '../manager/products_state.dart';
import 'product_item.dart';

class ProductsHorizontalList extends StatelessWidget {
  const ProductsHorizontalList({
    super.key,
    this.itemWidth = 170,
    this.onProductTap,
  });

  final double itemWidth;
  final ValueChanged<ProductModel>? onProductTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsError) {
          return const SizedBox.shrink();
        }

        final isLoading = state is! ProductsLoaded;
        final products = state is ProductsLoaded
            ? state.products
            : const <ProductModel>[];

        final itemCount = isLoading ? 10 : products.length;

        return Skeletonizer(
          enabled: isLoading,
          enableSwitchAnimation: true,
          child: SizedBox(
            height: 280.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: itemCount,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                if (isLoading) {
                  return _buildSkeletonItem(context);
                }
                final product = products[index];
                return SizedBox(
                  width: itemWidth.w,
                  child: ProductItem(
                    product: product,
                    onTap: () => onProductTap?.call(product),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkeletonItem(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: itemWidth.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: 60.w,
            height: 12.h,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            width: double.infinity,
            height: 32.h,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: 80.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ],
      ),
    );
  }
}