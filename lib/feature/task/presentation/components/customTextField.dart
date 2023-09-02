import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../cubit/task_cubit.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    this.controller,
    this.title,
    this.isPassword = false,
    this.onSave,
    this.onChange,
    this.onPressed,
    this.onSubmit,
    this.onTap,
    this.validator,
    this.prefix,
    this.type,
    this.suffix,
    this.labelText,
    this.hintText,
    this.width = double.infinity,
    this.readOnly = false,
  });

  String? labelText;
  String? hintText;
  String? title;
  bool readOnly;
  double? width;
  IconData? prefix;
  IconData? suffix;
  TextInputType? type;
  bool isPassword = false;
  Function(String?)? onSave;
  Function(String?)? onChange;
  Function(String?)? onSubmit;
  VoidCallback? onTap;
  VoidCallback? onPressed;
  String? Function(String?)? validator;
  TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title'),
        SizedBox(
          height: 8.h,
        ),
        SizedBox(
          height: 48.h,
          width: width,
          child: TextFormField(
            readOnly: readOnly,
            onTap: onTap,
            onSaved: onSave,
            validator: validator,
            controller: controller,
            decoration: InputDecoration(
              // prefixIcon: Icon(
              //   prefix,
              // ),

              suffixIcon: IconButton(
                iconSize: 16.sp,
                onPressed: onPressed,
                icon: Icon(
                  suffix,
                  color: AppColors.white,
                ),
              ),
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              labelText: labelText,
              fillColor: BlocProvider.of<TaskCubit>(context).isDark
                  ? AppColors.deepGrey
                  : AppColors.grey,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: AppColors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: AppColors.grey,
                ),
              ),
            ),
            obscureText: isPassword,
            onChanged: onChange,
            onFieldSubmitted: onSubmit,
            keyboardType: type,
          ),
        ),
      ],
    );
  }
}
