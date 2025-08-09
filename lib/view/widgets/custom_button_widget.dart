import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todo_task/utils/color_utils.dart';
import 'package:todo_task/utils/text_style_utils.dart';

class ShowActionModal extends StatelessWidget {
  final BuildContext context;
  final String title;
  final String content;
  final String? btnText;
  final VoidCallback callback;

  ShowActionModal({
    super.key,
    required this.context,
    required this.title,
    required this.content,
    this.btnText,
    required this.callback,
  }) {
    showCupertinoModalBottomSheet(
      context: context,
      enableDrag: false,
      barrierColor: kcPrimaryColor.withOpacity(0.3),
      topRadius: const Radius.circular(20),
      builder: (context) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        height: 300,
        child: Column(
          children: [
            Container(
              height: 5,
              width: 110,
              decoration: BoxDecoration(color: kcBgColor),
            ),
            SizedBox(height: 30),
            Text(title, style: stFDFDFD60018.copyWith(color: kcPrimaryColor)),
            const SizedBox(height: 15),
            Text(content, style: kt38383840014.copyWith(color: kcBgColor)),
            // SizedBox(height: 50),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomFlatButton(
                  title: 'Cancel',
                  onPressed: () => Navigator.of(context).pop(),
                  // textColor: kcBFBFBF,
                ),
                CustomRaisedButton(
                  width: MediaQuery.of(context).size.width * 0.5,
                  title: btnText ?? "Yes, Continue.",
                  onPressed: callback,
                ),
              ],
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class CustomFlatButton extends StatelessWidget {
  final String? title;
  final Color? textColor;
  final VoidCallback? onPressed;

  const CustomFlatButton({
    super.key,
    @required this.title,
    this.textColor = kcPrimaryColor,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title!,
          style: Theme.of(
            context,
          ).textTheme.labelLarge!.copyWith(color: textColor),
        ),
      ),
    );
  }
}

class CustomRaisedButton extends StatelessWidget {
  final Color? color;
  final bool? isLoading;
  final Color? textColor;
  final double? width;
  final VoidCallback? onPressed;
  final String title;
  final bool? isActive;
  final double? height;
  final double? radius;

  factory CustomRaisedButton.small({
    Key? key,
    required String title,
    required VoidCallback onPressed,
    bool? isLoading = false,
    bool? isActive = true,
    double? width,
    double? radius,
    double? height,
  }) {
    return CustomRaisedButton(
      key: key,
      title: title,
      onPressed: onPressed,
      radius: radius ?? 12,
      isLoading: isLoading,
      isActive: isActive,
      width: width,
      height: 40,
    );
  }

  const CustomRaisedButton({
    super.key,
    this.color,
    this.textColor,
    this.radius,
    required this.title,
    this.isLoading = false,
    this.isActive = true,
    this.width,
    this.height = 52,
    @required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height ?? 52,
        width: width,
        child: ElevatedButton(
          onPressed: (isLoading! || !isActive!) ? null : onPressed,
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? 25),
              ),
            ),
            backgroundColor: WidgetStateProperty.all(
              isActive!
                  ? (color ?? kcPrimaryColor)
                  : kcPrimaryColor.withOpacity(0.3),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: isLoading!
                ? const SizedBox(
                    height: 25,
                    child: CupertinoActivityIndicator(color: Colors.white),
                  )
                : Text(
                    title,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
