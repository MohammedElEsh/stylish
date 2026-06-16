import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

abstract final class ProductItemSkeleton {
  static Widget build(double itemWidth) {
    return SizedBox(
      width: itemWidth.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160.h,
            width: itemWidth.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            ),
            child: const Bone(),
          ),
          // Product info skeleton - matches original design (flex: 2, padding 8)
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Category & Title
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Bone.text(
                      fontSize: 12.sp,
                      width: itemWidth * 0.5,
                    ),
                    SizedBox(height: 2.h),
                    Bone.text(
                      fontSize: 14.sp,
                      width: itemWidth * 0.8,
                    ),
                  ],
                ),
                SizedBox(height: 18.h),

                // Price
                Bone.text(
                  fontSize: 16.sp,
                  width: itemWidth * 0.4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
