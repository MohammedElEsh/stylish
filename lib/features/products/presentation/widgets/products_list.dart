import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/pagination_helper.dart';
import 'package:stylish/features/products/presentation/widgets/product_item.dart';

import '../../data/models/product_model.dart';
import '../manager/products_cubit.dart';
import '../manager/products_state.dart';
import 'product_item_shimmer.dart';

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
        final isLoading = state is ProductsLoading;
        final isPaginationLoading = state is ProductsPaginationLoading;
        final isFailure = state is ProductsFailure;

        if (isFailure) {
          return const SizedBox.shrink();
        }

        List<ProductModel> products;

        if (state is ProductsSuccess) {
          products = state.products;
        } else if (isPaginationLoading) {
          products = state.currentProducts;
        } else {
          products = <ProductModel>[];
        }

        final paginationSkeletonCount = isPaginationLoading ? 2 : 0;

        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            PaginationHelper.onNotification(
              notification,
              () => context.read<ProductsCubit>().fetchMoreProducts(),
            );
            return false;
          },
          child: SizedBox(
            height: 280.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount:
                  isLoading ? 8 : products.length + paginationSkeletonCount,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                if (isLoading) {
                  return ProductItemShimmer.build(itemWidth);
                }

                if (index >= products.length) {
                  return ProductItemShimmer.build(itemWidth);
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
}
