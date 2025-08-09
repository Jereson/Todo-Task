import 'package:flutter/material.dart';
import 'package:todo_task/utils/color_utils.dart';
import 'package:todo_task/utils/text_style_utils.dart';

final inputDecoration = InputDecoration(
  filled: true,
  //TODO::: The actual value is withValue
  //but don't know the flutter sdk version of tester
  hintStyle: stFDFDFD60014.copyWith(color: kcFDFDFD.withOpacity(0.5)),
  fillColor: kcPrimaryColor.withOpacity(0.1),
  isDense: true,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: kcFDFDFD, width: 0.5),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: kcFDFDFD, width: 0.5),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: kcPrimaryColor),
  ),
);

final actionSearchDecoration = InputDecoration(
  filled: true,
  // fillColor: kcF5F9FF,
  hintText: 'Search action',
  // suffixIcon: Image.asset('assets/images/search_outline.png'),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide.none,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide.none,
  ),
);
