import 'package:ee034/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ee034/themes.dart';
import 'package:flutter/services.dart';
import 'package:ee034/page/profile_page.dart';
import 'package:ee034/utils/user_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await UserPreferences.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String title = 'User Profile';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.getUser();
    return MaterialApp(
      title: 'NTUtors',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}

