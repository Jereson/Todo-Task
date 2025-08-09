import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_task/utils/local_storage.dart';
import 'package:todo_task/view_model/task_vm.dart';

final getIt = GetIt.instance;

Future<void> setGetItUp() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => LocalStorage(sharedPreferences));

   getIt.registerSingleton<TaskVm>(TaskVm());
}
