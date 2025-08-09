import 'package:flutter/material.dart';
import 'package:todo_task/get_it.dart';
import 'package:todo_task/main.dart';
import 'package:todo_task/utils/local_storage.dart';
import 'package:todo_task/view/widgets/flushbar_widget.dart';

enum ViewState { busy, done, error, none, noInternet }

class BaseViewModel with ChangeNotifier {
  ViewState viewState = ViewState.none;
  String viewMessage = '';
  String errorMessage = '';
  bool _disposed = false;

  final localStarage = getIt.get<LocalStorage>();

  bool get hasEncounteredError =>
      viewState == ViewState.error || viewState == ViewState.noInternet;
  bool get isBusy => viewState == ViewState.done;

  requestRespone(String title, {bool error = false, bool canPop = true}) {
    if (canPop) {
      Navigator.of(navKey.currentContext!).pop();
    }
    flushbar(
      title: '',
      message: !error
          ? 'Task $title successfully'
          : 'Fail to $title task, please try again.',
      isSuccess: error,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
  }

  void setState({ViewState? viewState, String? viewMessage}) {
    if (viewState != null) this.viewState = viewState;
    if (viewMessage != null) this.viewMessage = viewMessage;
    if (!_disposed) notifyListeners();
  }

  String? defultValidator(String? value) =>
      value == null || value.trim().isEmpty ? 'field required' : null;
}
