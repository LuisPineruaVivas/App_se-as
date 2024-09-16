import 'package:flutter/material.dart';
import 'package:first_app/screens/log/login.dart';
import 'package:first_app/screens/log/signup.dart';
import 'package:first_app/components/button.dart';
import 'package:first_app/components/scaffold_home.dart';

class WelcomeScreen extends StatefulWidget {
  static String routeName = "/welcome";
  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldHome(
      image: 'images/home.png',
      child: Column(
        children: [
          Flexible(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 40.0,
                ),
                child: Center(
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(children: [
                          TextSpan(
                              text: 'Bienvenido\n',
                              style: TextStyle(
                                  fontSize: 45.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black)),
                          TextSpan(
                              text:
                                  '\nAprende lenguaje de señas de una manera facil e intuitiva',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black))
                        ]))),
              )),
          const Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Button(
                      buttonText: 'Inicia sesión',
                      onTap: LoginScreen(),
                    ),
                    SizedBox(height: 10),
                    Button(
                      buttonText: 'Registrarse',
                      onTap: SignUpScreen(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
