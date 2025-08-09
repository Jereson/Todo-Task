import 'package:flutter/material.dart';
import 'package:todo_task/get_it.dart';
import 'package:todo_task/utils/color_utils.dart';
import 'package:todo_task/utils/form_utilis.dart';
import 'package:todo_task/utils/string_extension.dart';
import 'package:todo_task/utils/text_style_utils.dart';
import 'package:todo_task/view/base_view_builder.dart';
import 'package:todo_task/view/widgets/custom_button_widget.dart';
import 'package:todo_task/view/widgets/no_task_widget.dart';
import 'package:todo_task/view_model/task_vm.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<TaskVm>(
      model: getIt(),
      builder: (tVm, _) {
        return Column(
          children: [
            if (tVm.isTaskSerch)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: tVm.searchController,
                  style: stFDFDFD60014,
                  onChanged: tVm.startTaskSearch,
                  decoration: inputDecoration.copyWith(
                    hintText: 'Search title',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: tVm.searchController.text.isEmpty
                        ? Offstage()
                        : IconButton(
                            onPressed: () => tVm.clearSearchTerm(),
                            icon: Icon(Icons.cancel),
                          ),
                  ),
                ),
              ),
            Expanded(
              child: tVm.filterTastList.isEmpty
                  ? NoSearchResultWidget()
                  : ListView.builder(
                      padding: EdgeInsets.all(20),
                      itemCount: tVm.filterTastList.length,
                      itemBuilder: (context, index) {
                        // final task = tVm.taskModel?.data?[index];
                        final task = tVm.filterTastList[index];
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => tVm.selectTask(task, index),
                          child: Container(
                            padding: EdgeInsets.only(
                              right: 10,
                              top: 10,
                              left: 10,
                            ),
                            margin: EdgeInsets.only(bottom: 20),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          (task.title ?? "").capitalize,
                                          style: stFDFDFD60018,
                                        ),
                                        Text(
                                          task.endDate ?? "",
                                          style: stC1C7D050014.copyWith(
                                            color: kcPrimaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text("Priority", style: stC1C7D050014),
                                        Icon(
                                          Icons.local_fire_department_rounded,
                                          color: task.priorityColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        task.description ?? "",
                                        style: st797A7F40010.copyWith(
                                          color: kcFDFDFD,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      'View  ',
                                      style: stFDFDFD60014.copyWith(
                                        color: kcPrimaryColor,
                                      ),
                                    ),

                                    IconButton(
                                      onPressed: () =>
                                          tVm.initiatetaskEdit(task),
                                      icon: Icon(
                                        Icons.edit_note_outlined,
                                        color: kcPrimaryColor,
                                        size: 30,
                                      ),
                                    ),

                                    IconButton(
                                      onPressed: () => ShowActionModal(
                                        context: context,
                                        title:
                                            'Delete ${(task.title ?? '').capitalize}',
                                        content:
                                            'Are you sure you want to delete ${(task.title ?? '').capitalize}',
                                        callback: () {
                                          tVm.selectTask(
                                            task,
                                            index,
                                            canRount: false,
                                          );

                                          tVm.deleteTask(false);
                                        },
                                      ),
                                      icon: Icon(
                                        Icons.delete_outline_rounded,
                                        color: kcC1C7D0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
