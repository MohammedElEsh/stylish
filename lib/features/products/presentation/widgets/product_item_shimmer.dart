import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

abstract final class ProductItemShimmer {
  static Widget build(double itemWidth) {
    return SizedBox(
      width: itemWidth.w,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE SECTION
            AspectRatio(
              aspectRatio: 7 / 8,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: Container(
                      width: 30.r,
                      height: 30.r,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // INFO SECTION
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 12.sp,
                    width: itemWidth * 0.45,
                    color: Colors.white,
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    height: 14.sp,
                    width: itemWidth * 0.75,
                    color: Colors.white,
                  ),
                  SizedBox(height: 18.h),
                  Container(
                    height: 18.sp,
                    width: itemWidth * 0.4,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
