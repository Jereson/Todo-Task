import 'package:flutter/material.dart';
import 'package:todo_task/utils/image_utils.dart';
import 'package:todo_task/utils/text_style_utils.dart';

class NoTaskWidget extends StatelessWidget {
  const NoTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Image.asset(imgList, height: 160)),
        SizedBox(height: 20),
        Text('No tasks yet', style: stFDFDFD60014),
        Text('Add new list using the + icon', style: st797A7F40010),
      ],
    );
  }
}

class NoSearchResultWidget extends StatelessWidget {
  const NoSearchResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Image.asset(imgList, height: 160)),
        SizedBox(height: 20),
        Text('Ooops!', style: stFDFDFD60014),
        Text('No search result found', style: st797A7F40010),
      ],
    );
  }
}
