import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../core/common/commons.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/widgets/customButton.dart';
import '../../components/customTextField.dart';
import '../../cubit/task_cubit.dart';
import '../../cubit/task_state.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            iconSize: 24.sp,
            color: BlocProvider.of<TaskCubit>(context).isDark
                ? AppColors.white
                : AppColors.background,
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        title: Text(
          AppStrings.addTask,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocConsumer<TaskCubit, TaskState>(
            listener: (context, state) {
              if (state is InsertTaskSucessState) {
                showToast(
                    message: 'Added Sucessfully', state: ToastStates.success);
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              final cubit = TaskCubit.get(context);
              return Form(
                key: BlocProvider.of<TaskCubit>(context).formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! Title
                    CustomTextField(
                      controller: cubit.titleController,
                      title: AppStrings.tilte,
                      hintText: AppStrings.tilteHint,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return AppStrings.tilteErrorMsg;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),
                    //! Note
                    CustomTextField(
                      controller: cubit.noteController,
                      title: AppStrings.note,
                      hintText: AppStrings.notehint,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return AppStrings.noteErrorMsg;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),
                    //! Date
                    CustomTextField(
                      title: AppStrings.date,
                      hintText: DateFormat.yMMMd().format(cubit.currentDate),
                      suffix: Icons.calendar_month_rounded,
                      onPressed: () async {
                        cubit.getDate(context);
                      },
                      readOnly: true,
                    ),
                    SizedBox(height: 24.h),
                    //! Start - End Time
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Start
                          Expanded(
                            child: CustomTextField(
                              readOnly: true,
                              title: AppStrings.startTime,
                              hintText: cubit.startTime,
                              suffix: Icons.timer_outlined,
                              onPressed: () async {
                                cubit.getStartTime(context);
                              },
                            ),
                          ),

                          SizedBox(
                            width: 27.w,
                          ),
                          //! end
                          Expanded(
                            child: CustomTextField(
                              readOnly: true,
                              title: AppStrings.endTime,
                              hintText: cubit.endTime,
                              suffix: Icons.timer_outlined,
                              onPressed: () async {
                                cubit.getEndTime(context);
                              },
                            ),
                          ),
                        ]),
                    SizedBox(height: 24.h),

                    //!Color
                    SizedBox(
                      height: 80.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // color
                          Text(
                            AppStrings.color,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Expanded(
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 6,
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 8.w),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    cubit.changeCheckMarkIndex(index);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: cubit.getColor(index),
                                    child: index == cubit.currentIndex
                                        ? Icon(
                                            Icons.check,
                                            color: AppColors.white,
                                            size: 25.r,
                                          )
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    //! add Task Button

                    SizedBox(height: 90.h),
                    state is InsertTaskLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ))
                        : CustomButton(
                            width: double.infinity,
                            text: AppStrings.createTask,
                            onPressed: () {
                              if (cubit.formKey.currentState!.validate()) {
                                cubit.insertTask();
                              }
                            },
                          )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
