import 'package:first_app/firebase_options.dart';
import 'package:first_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'auth/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     statusBarColor: Color.fromARGB(255, 0, 105, 155),
  //     statusBarBrightness: Brightness.light,
  //   ),}
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Señitas',
      debugShowCheckedModeBanner: false,
      initialRoute: Auth.routeName,
      routes: routes,
    );
  }
}
