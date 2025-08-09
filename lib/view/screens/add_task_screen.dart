import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_task/get_it.dart';
import 'package:todo_task/utils/color_utils.dart';
import 'package:todo_task/utils/form_utilis.dart';
import 'package:todo_task/utils/image_utils.dart';
import 'package:todo_task/utils/text_style_utils.dart';
import 'package:todo_task/view/base_view_builder.dart';
import 'package:todo_task/view/widgets/app_bar_widget.dart';
import 'package:todo_task/view/widgets/flushbar_widget.dart';
import 'package:todo_task/view/widgets/selecte_proirity_widget.dart';
import 'package:todo_task/view_model/task_vm.dart';

class AddTaskScreen extends StatefulWidget {
  static const routeName = '/add-task-screen';
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BaseViewBuilder<TaskVm>(
        dispose: (dis) => dis.disposetaskData(),
        model: getIt(),
        builder: (tVm, t) {
          return Scaffold(
            backgroundColor: kcBgColor,
            appBar: appBarWidget(
              tVm.isEditTask ? 'Edit ${tVm.titleController.text}' : 'Add Task',
            ),
            body: Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  SizedBox(height: 16.0),
                  Image.asset(imgToAdd, height: 80),
                  SizedBox(height: 10.0),

                  Text(
                    'Become a master of your daily schedule. \nFill the form below to track your tasks',
                    textAlign: TextAlign.center,
                    style: st797A7F40010.copyWith(color: kcFDFDFD),
                  ),
                  SizedBox(height: 20.0),

                  Text('Title', style: stC1C7D050014),
                  SizedBox(height: 5.0),
                  TextFormField(
                    controller: tVm.titleController,
                    style: stFDFDFD60014,
                    validator: tVm.defultValidator,
                    inputFormatters: [LengthLimitingTextInputFormatter(15)],
                    decoration: inputDecoration.copyWith(
                      hintText: 'Task Title',
                    ),
                  ),
                  SizedBox(height: 20.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('End Date', style: stC1C7D050014),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.42,
                            child: TextFormField(
                              controller: tVm.endDateController,
                              readOnly: true,
                              style: stFDFDFD60014,
                              validator: tVm.defultValidator,
                              onTap: () => tVm.pickEndDate(),
                              decoration: inputDecoration.copyWith(
                                hintText: 'Select',
                                suffixIcon: Icon(
                                  Icons.arrow_drop_down,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Priority', style: stC1C7D050014),

                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.42,
                            child: TextFormField(
                              controller: tVm.priorityController,
                              readOnly: true,
                              decoration: inputDecoration.copyWith(
                                suffixIcon: SelecteProirityWidget(),
                              ),
                              validator: tVm.defultValidator,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text('Description', style: stC1C7D050014),
                  SizedBox(height: 5.0),
                  TextFormField(
                    controller: tVm.descriptionController,
                    style: stFDFDFD60014,
                    decoration: inputDecoration,
                    maxLines: 5,
                    validator: tVm.defultValidator,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: kcPrimaryColor,
                    ),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      FocusScope.of(context).unfocus();
                      if (tVm.isEditTask) {
                        bool canEdit =
                            tVm.titleController.text == tVm.taskData?.title &&
                            tVm.descriptionController.text ==
                                tVm.taskData?.description &&
                            tVm.priorityController.text ==
                                tVm.taskData?.priority &&
                            tVm.endDateController.text == tVm.taskData?.endDate;
                        if (canEdit) {
                          flushbar(
                            message: 'No change have been made',
                            isSuccess: true,
                          );
                          return;
                        }
                        tVm.editTask();
                        return;
                      }
                      tVm.addTask();
                    },
                    child: Text(
                      tVm.isEditTask
                          ? 'Edit ${tVm.titleController.text}'
                          : 'Add Task',
                      style: stFDFDFD60018.copyWith(color: kcBgColor),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
