import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTypography {
  static TextStyle get regular14 => GoogleFonts.montserrat(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        height: 1,
        letterSpacing: 0,
      );

  static TextStyle get regular12 => GoogleFonts.montserrat(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        height: 1,
        letterSpacing: 0,
      );

  static TextStyle get semiBold20 => GoogleFonts.montserrat(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        height: 1,
        letterSpacing: 0,
      );

  static TextStyle get bold36 => GoogleFonts.montserrat(
        fontSize: 36.sp,
        fontWeight: FontWeight.w700,
        height: 43 / 36,
        letterSpacing: 0,
      );

  static TextStyle get extraBold24 => GoogleFonts.montserrat(
        fontSize: 24.sp,
        fontWeight: FontWeight.w800,
        height: 1,
        letterSpacing: 0,
      );

  static TextStyle get semiBold18 => GoogleFonts.montserrat(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        height: 1,
        letterSpacing: 0,
      );

  static TextStyle get semiBold14 => GoogleFonts.montserrat(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        height: 24 / 14,
        letterSpacing: 0.28,
      );
}
