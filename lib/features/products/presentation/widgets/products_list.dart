import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stylish/features/products/presentation/widgets/product_item.dart';

import '../../data/models/product_model.dart';
import '../manager/products_cubit.dart';
import '../manager/products_state.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({
    super.key,
    this.itemWidth = 170,
    this.aspectRatio = 0.75,
    this.onProductTap,
  });

  final double itemWidth;
  final double aspectRatio;
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
            state is ProductsLoaded ? state.products : const <ProductModel>[];

        return Skeletonizer(
          enabled: isLoading,
          enableSwitchAnimation: true,
          child: SizedBox(
            height: 280.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: isLoading ? 10 : products.length,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                if (isLoading) {
                  return SizedBox(
                    width: itemWidth.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // fake image
                        Container(
                          height: 160.h,
                          width: itemWidth.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: const Bone(),
                        ),

                        SizedBox(height: 8.h),

                        // fake title
                        Bone.text(
                          fontSize: 14.sp,
                          width: itemWidth * 0.6,
                          borderRadius: BorderRadius.circular(4.r),
                        ),

                        SizedBox(height: 6.h),

                        // fake subtitle/price
                        Bone.text(
                          fontSize: 12.sp,
                          width: itemWidth * 0.4,
                          borderRadius: BorderRadius.circular(4.r),
                        ),

                        SizedBox(height: 36.h),

                        Bone.text(
                          fontSize: 14.sp,
                          width: itemWidth * 0.3,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ],
                    ),
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
        );
      },
    );
  }
}
