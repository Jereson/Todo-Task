import "package:flutter/gestures.dart";

class MultiTouchGestureRecognizer extends MultiTapGestureRecognizer {
  MultiTouchGestureRecognizerCallback? onMultiTap;
  SingleTouchGestureRecognizerCallback? onSingleTap;
  Offset firstPoint = const Offset(0, 0);
  var numberOfTouches = 0;

  MultiTouchGestureRecognizer() {
    super.onTapDown = (pointer, details) => addTouch(pointer, details);
    super.onTapUp = (pointer, details) => removeTouch(pointer, details);
    super.onTapCancel = (pointer) => cancelTouch(pointer);
    super.onTap = (pointer) => captureDefaultTap(pointer);
  }

  void addTouch(int pointer, TapDownDetails details) {
    numberOfTouches++;
    if (numberOfTouches == 1) {
      firstPoint = details.localPosition;
      onSingleTap?.call(details.localPosition);
    }

    if (numberOfTouches == 2) {
      onMultiTap?.call(firstPoint, details.localPosition);
    }
  }

  void removeTouch(int pointer, TapUpDetails details) {
    numberOfTouches = 0;
  }

  void cancelTouch(int pointer) {
    numberOfTouches = 0;
  }

  void captureDefaultTap(int pointer) {}

  @override
  set onTapDown(onTapDown) {}

  @override
  set onTapUp(onTapUp) {}

  @override
  set onTapCancel(onTapCancel) {}

  @override
  set onTap(onTap) {}
}

typedef MultiTouchGestureRecognizerCallback = void Function(
    Offset firstPoint, Offset secondPoint);
typedef SingleTouchGestureRecognizerCallback = void Function(Offset point);
