import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_task/get_it.dart';
import 'package:todo_task/utils/color_utils.dart';
import 'package:todo_task/utils/image_utils.dart';
import 'package:todo_task/view/base_view_builder.dart';
import 'package:todo_task/view/screens/add_task_screen.dart';
import 'package:todo_task/view/widgets/app_bar_widget.dart';
import 'package:todo_task/view/widgets/no_task_widget.dart';
import 'package:todo_task/view/widgets/task_list_widget.dart';
import 'package:todo_task/view_model/task_vm.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<TaskVm>(
      model: getIt(),
      initState: (init) {
        init.getAllTask();
      },
      builder: (tVm, _) {
        return Scaffold(
          backgroundColor: kcBgColor,
          appBar: appBarWidget(
            'Todo Task',
            centerTitle: false,
            actions: [
              if (tVm.taskModel != null &&
                  (tVm.taskModel?.data?.isNotEmpty ?? false))
                GestureDetector(
                  onTap: () => tVm.initiateSearch(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: tVm.isTaskSerch
                        ? Icon(Icons.cancel_outlined, color: kcFDFDFD)
                        : Image.asset(imgSearch, height: 24, width: 24),
                  ),
                ),
            ],
          ),
          body: !(tVm.hasFetchTask)
              ? Center(child: CupertinoActivityIndicator(color: kcPrimaryColor))
              : (tVm.listItemStatu || (tVm.taskModel?.data?.isEmpty ?? false))
              ? NoTaskWidget()
              : TaskListWidget(),
          floatingActionButton: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => Navigator.pushNamed(context, AddTaskScreen.routeName),
            child: Image.asset(imgAddTodo, height: 50),
          ),
        );
      },
    );
  }
}
