import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static TextStyle get h1 => GoogleFonts.montserrat(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get h2 => GoogleFonts.montserrat(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get h3 => GoogleFonts.montserrat(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get bodyLarge => GoogleFonts.montserrat(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get bodyMedium => GoogleFonts.montserrat(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get bodySmall => GoogleFonts.montserrat(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get label => GoogleFonts.montserrat(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      );
}