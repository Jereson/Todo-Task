import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:todo_task/main.dart';
import 'package:todo_task/utils/color_utils.dart';

flushbar({
  String? title,
  required String message,
  bool isSuccess = false,
  int duration = 4,
}) {
  Flushbar(
    // title: title,
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.GROUNDED,
    duration: Duration(seconds: duration),
    backgroundColor: !isSuccess ? kcPrimaryColor : kcBgColor,
    // backgroundColor: kcPrimaryColor,
    icon: isSuccess
        ? const Icon(Icons.info, color: kcWhite)
        : const Icon(Icons.error_outline, color: kcBgColor),
  ).show(navKey.currentContext!);
}
