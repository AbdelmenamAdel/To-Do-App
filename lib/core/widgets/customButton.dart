// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.onPressed,
      this.iconData,
      this.height,
      required this.text,
      this.width,
      this.backgroundColor = AppColors.primary});
  @required
  String text;
  IconData? iconData;
  VoidCallback onPressed;
  double? width;
  double? height;

  Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? (height = 48.h),
      width: width ?? (width = 90.w),
      child: ElevatedButton(
        onPressed: onPressed,
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              backgroundColor: MaterialStatePropertyAll(backgroundColor),
            ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: AppColors.white, fontSize: 16.sp),
        ),
      ),
    );
  }
}
