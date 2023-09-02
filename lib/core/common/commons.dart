import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/app_colors.dart';

void navigate({required BuildContext context, required Widget screen}) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
}

//! Show Toast
void showToast({
  required String message,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: getState(state),
      textColor: Colors.white,
      fontSize: 16.0.sp);
}

enum ToastStates { error, success, warining }

Color getState(ToastStates state) {
  switch (state) {
    case ToastStates.error:
      return AppColors.red;
    case ToastStates.success:
      return AppColors.primary;
    case ToastStates.warining:
      return AppColors.orange;
  }
}
