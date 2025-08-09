import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_task/get_it.dart';
import 'package:todo_task/router.dart';
import 'package:todo_task/utils/color_utils.dart';
import 'package:todo_task/view/screens/home_screen.dart';

final navKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await setGetItUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO Task',
      debugShowCheckedModeBanner: false,
      navigatorKey: navKey,
      theme: ThemeData(fontFamily: 'DM Sans', primaryColor: kcPrimaryColor),
      home: const HomeScreen(),
      routes: routes,
    );
  }
}
