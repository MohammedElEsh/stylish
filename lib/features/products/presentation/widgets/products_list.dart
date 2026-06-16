import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stylish/core/pagination/pagination_helper.dart';
import 'package:stylish/features/products/presentation/widgets/product_item.dart';

import '../../data/models/product_model.dart';
import '../manager/products_cubit.dart';
import '../manager/products_state.dart';
import 'product_item_skeleton.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({
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

        final products =
            state is ProductsLoaded ? state.products : <ProductModel>[];

        final hasMore = state is ProductsLoaded && state.hasMore;

        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            PaginationHelper.onNotification(
              notification,
              () => context.read<ProductsCubit>().loadMore(),
            );
            return false;
          },
          child: Skeletonizer(
            enabled: isLoading,
            child: SizedBox(
              height: 280.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: isLoading ? 8 : products.length + (hasMore ? 1 : 0),
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                itemBuilder: (context, index) {
                  if (isLoading) {
                    return ProductItemSkeleton.build(itemWidth);
                  }

                  if (index >= products.length) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
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
          ),
        );
      },
    );
  }
}
