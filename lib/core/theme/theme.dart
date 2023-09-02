import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

ThemeData getAppDarkTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    //scaffoldBackgroundColor
    scaffoldBackgroundColor: AppColors.background,
    //appBar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
    ),
    //text theme
    //! Text
    textTheme: TextTheme(
      displayLarge: GoogleFonts.lato(
          fontWeight: FontWeight.bold, color: AppColors.white, fontSize: 30.sp),
      displayMedium: GoogleFonts.lato(
          color: AppColors.white.withOpacity(.87), fontSize: 16.sp),
      bodyMedium: GoogleFonts.lato(color: AppColors.white, fontSize: 16.sp),
      bodyLarge: GoogleFonts.lato(color: AppColors.white, fontSize: 24.sp),
      headlineLarge: GoogleFonts.lato(
          fontWeight: FontWeight.bold, color: AppColors.white, fontSize: 40.sp),
      displaySmall: GoogleFonts.lato(
          color: AppColors.white.withOpacity(.44), fontSize: 16.sp),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)))),
    inputDecorationTheme: InputDecorationTheme(
        //enabled border
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        //fouced border
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        //hint
        hintStyle: GoogleFonts.lato(
          color: AppColors.white,
          fontSize: 16.sp,
        ),
        //fill color
        fillColor: AppColors.lightBlack,
        filled: true),
  );
}

ThemeData getAppTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    //scaffoldBackgroundColor
    scaffoldBackgroundColor: AppColors.white,
    //appBar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
    ),
//! Text
    textTheme: TextTheme(
      displayLarge: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
          color: AppColors.background,
          fontSize: 30.sp),
      displayMedium: GoogleFonts.lato(
          color: AppColors.background.withOpacity(.87), fontSize: 16.sp),
      bodyMedium:
          GoogleFonts.lato(color: AppColors.background, fontSize: 16.sp),
      bodyLarge: GoogleFonts.lato(color: AppColors.background, fontSize: 24.sp),
      headlineLarge: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
          color: AppColors.background,
          fontSize: 40.sp),
      displaySmall: GoogleFonts.lato(
          color: AppColors.background.withOpacity(.44), fontSize: 16.sp),
    ),

    //button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4)))),
  );
}
