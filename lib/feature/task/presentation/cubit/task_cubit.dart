import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:up_to_do/feature/task/presentation/cubit/task_state.dart';
import '../../../../core/database/cache/cache_helper.dart';
import '../../../../core/database/sqflite_helper/sqflite_helper.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/model/task_model.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  static TaskCubit get(context) => BlocProvider.of(context);
  //!!!!!!!!!!!!!!!!!!!!!!!!! VARIABLES !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  DateTime currentDate = DateTime.now();
  DateTime selctedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now());
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 45)));
  int currentIndex = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isDark = false;

  //! Get date from Cubit
  void getDate(context) async {
    emit(GetDateLoadingState());
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      currentDate = pickedDate;
      emit(GetDateSucessState());
    } else {
      print('pickedDate == null');
      emit(GetDateErrorState());
    }
  }

  //! Get Start Time from Cubit
  void getStartTime(context) async {
    emit(GetStartTimeLoadingState());
    TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (pickedStartTime != null) {
      startTime = pickedStartTime.format(context);
      emit(GetStartTimeSucessState());
    } else {
      print('pickedStartTime ==null');
      emit(GetStartTimeErrorState());
    }
  }

  //! Get End Time from Cubit
  void getEndTime(context) async {
    emit(GetEndTimeLoadingState());

    TimeOfDay? pickedEndTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (pickedEndTime != null) {
      endTime = pickedEndTime.format(context);
      emit(GetEndTimeSucessState());
    } else {
      print('pickedStartTime ==null');
      emit(GetEndTimeErrorState());
    }
  }

  //! Get Color
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

  //! Change CheckMark Index
  void changeCheckMarkIndex(index) {
    currentIndex = index;
    emit(ChangeCheckMarkIndexState());
  }

  //! Filter Tasks
  void getSelectedDate(date) {
    emit(GetSelectedDateLoadingState());
    selctedDate = date;

    emit(GetSelectedDateSucessState());
    getTasks();
  }

  //!!!!!!!!!!!!!!!!!!!!!!! DATABASE !!!!!!!!!!!!!!!!!
  List<TaskModel> tasksList = [];

  //! Insert Task
  void insertTask() async {
    emit(InsertTaskLoadingState());
    try {
      //! to make screen wait 1 second
      await Future.delayed(const Duration(seconds: 2));
      await sl<SqfliteHelper>().insertToDB(
        TaskModel(
          date: DateFormat.yMd().format(currentDate),
          title: titleController.text,
          note: noteController.text,
          startTime: startTime,
          endTime: endTime,
          isCompleted: 0,
          color: currentIndex,
        ),
      );
      titleController.clear();
      noteController.clear();
      currentDate = DateTime.now();
      startTime = DateFormat('hh:mm a').format(DateTime.now());
      endTime = DateFormat('hh:mm a')
          .format(DateTime.now().add(const Duration(minutes: 45)));
      currentIndex = 0;
      emit(InsertTaskSucessState());
      getTasks();
    } catch (e) {
      emit(InsertTaskErrorState());
    }
  }

  //! Get Task
  void getTasks() async {
    emit(GetDateLoadingState());
    await sl<SqfliteHelper>().getFromDB().then((value) {
      tasksList = value
          .map((e) => TaskModel.fromJson(e))
          .toList()
          .where(
            (element) => element.date == DateFormat.yMd().format(selctedDate),
          )
          .toList();
      emit(GetDateSucessState());
    }).catchError((e) {
      print(e.toString());
      emit(GetDateErrorState());
    });
  }

  //! Update Task
  void updateTask(id) async {
    emit(UpdateTaskLoadingState());
    await sl<SqfliteHelper>().updatedDB(id).then((value) {
      emit(UpdateTaskSucessState());
      getTasks();
    }).catchError((e) {
      print(e.toString());
      emit(UpdateTaskErrorState());
    });
  }

  //! Delete Task
  void deleteTask(id) async {
    emit(DeleteTaskLoadingState());
    await sl<SqfliteHelper>().deleteFromDB(id).then((value) {
      emit(DeleteTaskSucessState());
      getTasks();
    }).catchError((e) {
      print(e.toString());
      emit(DeleteTaskErrorState());
    });
  }

  //! Change App Theme
  void changeTheme() async {
    isDark = !isDark;
    await sl<CacheHelper>().saveData(key: 'isDark', value: isDark);
    emit(ChangeThemeState());
  }

  //! Get App Theme
  void getTheme() async {
    isDark = await sl<CacheHelper>().getData(key: 'isDark');
    emit(GetThemeState());
  }
}
