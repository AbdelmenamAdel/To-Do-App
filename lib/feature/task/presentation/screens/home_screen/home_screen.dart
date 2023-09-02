import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/common/commons.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/widgets/customButton.dart';
import '../../../data/model/task_model.dart';
import '../../cubit/task_cubit.dart';
import '../../cubit/task_state.dart';
import '../add_task_screen/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder<TaskCubit, TaskState>(
            // listener: (context, state) {
            //   if (state is UpdateTaskSucessState) {
            //     showToast(
            //         message: 'Completed Successfully',
            //         state: ToastStates.success);
            //     Navigator.pop(context);
            //   }
            //   if (state is DeleteTaskSucessState) {
            //     showToast(
            //         message: 'Deleted Successfully',
            //         state: ToastStates.success);
            //     Navigator.pop(context);
            //   }
            // },
            builder: (context, state) {
              final cubit = TaskCubit.get(context);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //! date now
                  Row(
                    children: [
                      Text(DateFormat.yMMMMd().format(DateTime.now()),
                          style: Theme.of(context).textTheme.bodyLarge),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          cubit.changeTheme();
                        },
                        icon: Icon(
                          Icons.mode_night,
                          color: cubit.isDark
                              ? AppColors.white
                              : AppColors.background,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  //! Today
                  Text(AppStrings.today,
                      style: Theme.of(context).textTheme.bodyLarge),
                  //! date picker
                  DatePicker(
                    height: 104.h,
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: AppColors.primary,
                    selectedTextColor: AppColors.white,
                    dateTextStyle: Theme.of(context).textTheme.displayMedium!,
                    dayTextStyle: Theme.of(context).textTheme.displayMedium!,
                    monthTextStyle: Theme.of(context).textTheme.displayMedium!,
                    onDateChange: (date) {
                      BlocProvider.of<TaskCubit>(context).getSelectedDate(date);
                    },
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  //! no tasks
                  cubit.tasksList.isEmpty
                      ? noTasksWidget(context)
                      : Expanded(
                          child: ListView.builder(
                            itemCount: BlocProvider.of<TaskCubit>(context)
                                .tasksList
                                .length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          padding: const EdgeInsets.all(24),
                                          height: 240.h,
                                          color: AppColors.deepGrey,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              //taskCompleted
                                              BlocProvider.of<TaskCubit>(
                                                              context)
                                                          .tasksList[index]
                                                          .isCompleted ==
                                                      1
                                                  ? Container()
                                                  : CustomButton(
                                                      width: double.infinity,
                                                      text: AppStrings
                                                          .taskCompleted,
                                                      onPressed: () {
                                                        cubit.updateTask(
                                                            BlocProvider.of<
                                                                        TaskCubit>(
                                                                    context)
                                                                .tasksList[
                                                                    index]
                                                                .id);
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                              //deleteTask
                                              CustomButton(
                                                width: double.infinity,
                                                text: AppStrings.deleteTask,
                                                backgroundColor: AppColors.red,
                                                onPressed: () {
                                                  cubit.deleteTask(BlocProvider
                                                          .of<TaskCubit>(
                                                              context)
                                                      .tasksList[index]
                                                      .id);
                                                  Navigator.pop(context);
                                                },
                                              ),

                                              //cancel
                                              CustomButton(
                                                width: double.infinity,
                                                text: AppStrings.cancel,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: TaskComponent(
                                    taskModel: cubit.tasksList[index],
                                  ));
                            },
                          ),
                        ),
                ],
              );
            },
          ),
        ),
        //fab
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigate(context: context, screen: const AddTaskScreen());
          },
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Column noTasksWidget(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppAssets.noTasks),
        Text(
          AppStrings.noTaskTitle,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 20.sp,
              ),
        ),
        Text(
          AppStrings.noTaskSubTitle,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ],
    );
  }
}

class TaskComponent extends StatelessWidget {
  const TaskComponent({
    super.key,
    required this.taskModel,
  });
  final TaskModel taskModel;
  Color getColor(index) {
    switch (index) {
      case 0:
        return AppColors.red;
      case 1:
        return AppColors.green;
      case 2:
        return AppColors.blueGrey;
      case 3:
        return AppColors.blue;
      case 4:
        return AppColors.orange;
      case 5:
        return AppColors.purple;
      default:
        return AppColors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: getColor(taskModel.color),
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          //column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //title
                Text(
                  taskModel.title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: 8.h),

                //row
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.timer,
                      color: AppColors.white,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '${taskModel.startTime} - ${taskModel.endTime}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                //note
                Text(
                  taskModel.note,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          //divider
          Container(
            height: 75.h,
            width: 1.w,
            color: Colors.white,
            margin: const EdgeInsets.only(right: 10),
          ),
          // const SizedBox(width: 10,),
          //text
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              taskModel.isCompleted == 1
                  ? AppStrings.completed
                  : AppStrings.toDo,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          )
        ],
      ),
    );
  }
}
