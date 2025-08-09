import 'package:flutter/material.dart';
import 'package:todo_task/view/screens/add_task_screen.dart';
import 'package:todo_task/view/screens/task_detail_screen.dart';

final routes = <String, WidgetBuilder>{
  AddTaskScreen.routeName: (context) => const AddTaskScreen(),
  TaskDetailScreen.routeName: (context) => const TaskDetailScreen(),

};