import 'package:flutter/material.dart';
import 'package:todo_task/utils/color_utils.dart';
import 'package:todo_task/utils/text_style_utils.dart';

AppBar appBarWidget(
  String title, {
  bool centerTitle = true,
  List<Widget>? actions,
}) {
  return AppBar(
    iconTheme: IconThemeData(color: kcFDFDFD),
    title: Text(title, style: stFDFDFD60018),
    backgroundColor: kcBgColor,
    centerTitle: centerTitle,
    actions: actions,
  );
}
