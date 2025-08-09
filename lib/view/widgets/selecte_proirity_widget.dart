import 'package:flutter/material.dart';
import 'package:todo_task/get_it.dart';
import 'package:todo_task/utils/color_utils.dart';
import 'package:todo_task/utils/text_style_utils.dart';
import 'package:todo_task/view/base_view_builder.dart';
import 'package:todo_task/view_model/task_vm.dart';

class SelecteProirityWidget extends StatelessWidget {
  const SelecteProirityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<TaskVm>(
      model: getIt(),
      builder: (tVm, _) {
        return PopupMenuButton<String>(
          icon: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${tVm.priorityController.text.isNotEmpty ? tVm.priorityController.text : "Select"}  ',
                style: stFDFDFD60014.copyWith(
                  color: tVm.priorityController.text.isEmpty
                      ? kcFDFDFD.withOpacity(0.5)
                      : kcFDFDFD,
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
          itemBuilder: (BuildContext context) => ['High', 'Medium', 'Low']
              .map(
                (e) => PopupMenuItem<String>(
                  onTap: () => tVm.selectPriority(e),
                  value: tVm.priority,
                  child: Text(e),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
