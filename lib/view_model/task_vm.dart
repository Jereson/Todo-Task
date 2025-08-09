import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:todo_task/main.dart';
import 'package:todo_task/model/task_model.dart';
import 'package:todo_task/utils/color_utils.dart';
import 'package:todo_task/utils/string_extension.dart';
import 'package:todo_task/view/screens/add_task_screen.dart';
import 'package:todo_task/view/screens/task_detail_screen.dart';
import 'package:todo_task/view/widgets/custom_loader/ndialog.dart';
import 'package:todo_task/view_model/base_view_model.dart';

class TaskVm extends BaseViewModel {
  final titleController = TextEditingController();
  final endDateController = TextEditingController();
  final priorityController = TextEditingController();
  final descriptionController = TextEditingController();
  final searchController = TextEditingController();

  String? priority;
  DateTime? rawDate;

  TaskModel? taskModel;
  TaskData? taskData;

  int? selectTaskIndex;

  bool? _listItemStatu;
  bool get listItemStatu => _listItemStatu ?? true;

  bool? _hasFetchTask;
  bool get hasFetchTask => _hasFetchTask ?? false;

  bool isEditTask = false;

  bool isTaskSerch = false;

  List<TaskData> get filterTastList =>
      taskModel?.data
          ?.where(
            (e) =>
                e.title?.toLowerCase().contains(
                  searchController.text.toLowerCase(),
                ) ??
                false,
          )
          .toList() ??
      [];

  void clearSearchTerm() {
    searchController.clear();
    setState();
  }

  void initiateSearch() {
    isTaskSerch = !isTaskSerch;
    searchController.clear();
    setState();
  }

  void startTaskSearch(String? val) {
    searchController.text = val ?? "";
    setState();
  }

  void selectPriority(String val) {
    priority = val;
    priorityController.text = val;
    setState();
  }

  void selectTask(TaskData? data, int index, {bool canRount = true}) {
    taskData = data;
    selectTaskIndex = index;
    if (!canRount) return;
    Navigator.of(navKey.currentContext!).pushNamed(TaskDetailScreen.routeName);
  }

  void initiatetaskEdit(TaskData? task) {
    titleController.text = task?.title ?? "";
    endDateController.text = task?.endDate ?? "";
    priorityController.text = task?.priority ?? "";
    descriptionController.text = task?.description ?? '';
    isEditTask = true;
    setState();

    Navigator.of(navKey.currentContext!).pushNamed(AddTaskScreen.routeName);
  }

  Future<void> getAllTask() async {
    try {
      final task = localStarage.getTask;
      _listItemStatu = task.isEmpty;

      if (listItemStatu) {
        _hasFetchTask = true;
        setState();
        return;
      }
      final formTask = task.fixToJson;

      Map<String, dynamic> response = await jsonDecode(formTask);

      taskModel = TaskModel.fromJson(response);
      _hasFetchTask = true;

      setState();
    } catch (e) {
      print(e);
      requestRespone('fetch', error: true);
    }
  }

  Future<void> addTask() async {
    CustomProgressDialog progressDialog = CustomProgressDialog();
    try {
      progressDialog.show();
      final oldTask = localStarage.getTask;

      if (oldTask.isEmpty) {
        String newTask =
            '${{
              "data": [
                {"title": titleController.text, "priority": priorityController.text, "description": descriptionController.text, "endDate": endDateController.text},
              ],
            }}';
        final dataToString = newTask.toString();
        await localStarage.setTask(dataToString);
      } else {
        final data = TaskData(
          title: titleController.text,
          priority: priorityController.text,
          description: descriptionController.text,
          endDate: endDateController.text,
        );
        taskModel?.data?.add(data);

        String jsonString = jsonEncode({
          "data": taskModel?.data?.map((e) => e.toJson()).toList(),
        });
        await localStarage.setTask(jsonString);
      }

      await getAllTask();
      progressDialog.dismiss();

      requestRespone('Added');
      disposetaskData();
      setState();
    } catch (e) {
      progressDialog.dismiss();
      requestRespone('add', error: true);
    }
  }

  Future<void> editTask() async {
    try {
      taskData = TaskData(
        title: titleController.text,
        priority: priorityController.text,
        description: descriptionController.text,
        endDate: endDateController.text,
      );
      taskModel?.data?[selectTaskIndex!] = taskData!;

      String jsonString = jsonEncode({
        "data": taskModel?.data?.map((e) => e.toJson()).toList(),
      });

      await localStarage.setTask(jsonString);
      await getAllTask();
      requestRespone('Edited');
    } catch (e) {
      requestRespone('edit', error: true);
    }
  }

  Future<void> deleteTask(bool canPop) async {
    Navigator.of(navKey.currentContext!).pop();
    try {
      taskData = TaskData(
        title: titleController.text,
        priority: priorityController.text,
        description: descriptionController.text,
        endDate: endDateController.text,
      );
      taskModel?.data?.removeAt(selectTaskIndex!);

      String jsonString = jsonEncode({
        "data": taskModel?.data?.map((e) => e.toJson()).toList(),
      });

      await localStarage.setTask(jsonString);
      await getAllTask();
      setState();
      requestRespone('Deleted', canPop: canPop);
    } catch (e) {
      requestRespone('delete', error: true);
    }
  }

  void pickEndDate() {
    DatePickerBdaya.showDatePicker(
      navKey.currentContext!,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime(2050, 1, 1),

      theme: const DatePickerThemeBdaya(
        backgroundColor: kcPrimaryColor,
        headerColor: kcPrimaryColor,
        itemHeight: 50,
        doneStyle: TextStyle(
          color: kcBgColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        containerHeight: 300,
      ),
      onChanged: (date) {},
      onConfirm: (date) {
        final day = '${date.day}'.length == 1 ? '0${date.day}' : '${date.day}';
        final month = '${date.month}'.length == 1
            ? '0${date.month}'
            : '${date.month}';
        endDateController.text = '$day-$month-${date.year}';
        rawDate = date;
        // rawDate

        // logger.d('confirm $birthDay');
        setState();
      },
      currentTime: DateTime.now(),

      locale: LocaleType.en,
    );
  }

  disposetaskData() {
    titleController.clear();
    endDateController.clear();
    priorityController.clear();
    descriptionController.clear();
    priority = null;
    rawDate = null;
    isEditTask = false;
  }
}
