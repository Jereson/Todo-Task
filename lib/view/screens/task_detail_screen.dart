import 'package:flutter/material.dart';
import 'package:todo_task/get_it.dart';
import 'package:todo_task/utils/color_utils.dart';
import 'package:todo_task/utils/string_extension.dart';
import 'package:todo_task/utils/text_style_utils.dart';
import 'package:todo_task/view/base_view_builder.dart';
import 'package:todo_task/view/widgets/app_bar_widget.dart';
import 'package:todo_task/view/widgets/custom_button_widget.dart';
import 'package:todo_task/view_model/task_vm.dart';

class TaskDetailScreen extends StatelessWidget {
  static const routeName = '/task-detail';
  const TaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<TaskVm>(
      model: getIt(),
      builder: (tVm, _) {
        final task = tVm.taskData;
        return Scaffold(
          backgroundColor: kcBgColor,
          appBar: appBarWidget('Task Details'),
          body: ListView(
            padding: EdgeInsets.all(16),
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(0xFF242632),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (task?.title ?? "").capitalize,
                              style: stFDFDFD60018,
                            ),
                            Text(
                              task?.endDate ?? "",
                              style: stC1C7D050014.copyWith(
                                color: kcPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Priority: ${task?.priority ?? ""}",
                              style: stC1C7D050014,
                            ),
                            Icon(
                              Icons.local_fire_department_rounded,
                              color: task?.priorityColor ?? kcPrimaryColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(),

                    SizedBox(height: 20),

                    Text(
                      task?.description ?? "",
                      style: stC1C7D050014.copyWith(color: kcFDFDFD),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => tVm.initiatetaskEdit(task),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: kcPrimaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.edit_note_outlined,
                      color: kcFDFDFD,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () => ShowActionModal(
                    context: context,
                    title: 'Delete ${(task?.title ?? '').capitalize}',
                    content:
                        'Are you sure you want to delete ${(task?.title ?? '').capitalize}',
                    callback: () => tVm.deleteTask(true),
                  ),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: kcRed,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.delete_outline_rounded, color: kcFDFDFD),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
