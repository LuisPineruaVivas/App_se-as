import 'package:first_app/auth/auth.dart';
import 'package:first_app/screens/evaluations/evaluations.dart';
import 'package:first_app/screens/lesson/lesson1_screen.dart';
import 'package:first_app/screens/home/home.dart';
import 'package:first_app/screens/home/perfin.dart';
import 'package:first_app/screens/lesson/lesson2_screen.dart';
import 'package:first_app/screens/lesson/lesson3_screen.dart';
import 'package:first_app/screens/lesson/lesson4_screen.dart';
import 'package:first_app/screens/lesson/lesson5_screen.dart';
import 'package:first_app/screens/lesson/lesson6_screen.dart';
import 'package:first_app/screens/lesson/lesson7_screen.dart';
import 'package:first_app/screens/lesson/lesson8_screen.dart';
import 'package:first_app/screens/levels/levels.dart';
import 'package:first_app/screens/log/forgot_password.dart';
import 'package:first_app/screens/log/login.dart';
import 'package:first_app/screens/log/signup.dart';
import 'package:first_app/screens/welcome/welcome.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  Auth.routeName: (context) => const Auth(),
  WelcomeScreen.routeName: (context) => const WelcomeScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  PerfilScreen.routeName: (context) => const PerfilScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  ChangePasswordScreen.routeName: (context) => const ChangePasswordScreen(),
  LevelsScreen.routeName: (context) => const LevelsScreen(),
  Lesson1Screen.routeName: (context) => const Lesson1Screen(),
  Lesson2Screen.routeName: (context) => const Lesson2Screen(),
  Lesson3Screen.routeName: (context) => const Lesson3Screen(),
  Lesson4Screen.routeName: (context) => const Lesson4Screen(),
  Lesson5Screen.routeName: (context) => const Lesson5Screen(),
  Lesson6Screen.routeName: (context) => const Lesson6Screen(),
  Lesson7Screen.routeName: (context) => const Lesson7Screen(),
  Lesson8Screen.routeName: (context) => const Lesson8Screen(),
  EvaluationScreen.routeName: (context) => const EvaluationScreen(),
};
