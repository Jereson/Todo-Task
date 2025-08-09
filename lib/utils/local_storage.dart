import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferences prefs;

  LocalStorage(this.prefs);

  Future setTask(String task) async {
    prefs.setString('task', task);
  }

  String get getTask {
    return prefs.getString('task') ?? '';
  }
}
