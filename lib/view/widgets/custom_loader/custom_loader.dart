import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todo_task/utils/color_utils.dart';
import 'package:todo_task/utils/text_style_utils.dart';

class CustomLoader extends StatelessWidget {
  final Color bgColor;
  final String? text;
  const CustomLoader({super.key, this.text, this.bgColor = kcPrimaryColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          // Container(
          //   height: 70,
          //   width: 70,
          //   decoration: BoxDecoration(
          //       color: bgColor, borderRadius: BorderRadius.circular(10)),
          //   child: SpinKitWaveSpinner(
          //     duration: const Duration(milliseconds: 1200),
          //     waveColor: kcWhite.withValues(alpha: 0.4),
          //     color: kcWhite,
          //   ),
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // height: 59,
                // width: 59,
                decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  color: bgColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: SpinKitWaveSpinner(
                  size: 60,
                  duration: const Duration(milliseconds: 1200),
                  waveColor: kcWhite.withValues(alpha: 0.4),
                  color: kcWhite,
                ),
              ),
              const SizedBox(height: 5),
              Shimmer.fromColors(
                baseColor: kcPrimaryColor,
                highlightColor: kcBgColor.withValues(alpha: 0.2),
                child: Text(
                  text ?? 'a moment...',
                  style: st181B2450015.copyWith(fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
    );
  }
}
