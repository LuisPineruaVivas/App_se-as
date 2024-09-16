import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/auth/auth.dart';
import 'package:first_app/screens/home/home.dart';
import 'package:flutter/material.dart';

class LoginController {
  late BuildContext context;
  late Function refresh;

  late AuthAppProvider _auth;

  final user = FirebaseAuth.instance;

  TextEditingController correo = TextEditingController();
  TextEditingController contrasena = TextEditingController();

  final formLoginKey = GlobalKey<FormState>();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    _auth = AuthAppProvider();
  }

  void login() async {
    String email = correo.text.trim();
    String password = contrasena.text.trim();

    try {
      bool isLogin = await _auth.login(email, password);
      if (isLogin) {
        if (user.currentUser != null) {
          Navigator.pushNamed(context, HomeScreen.routeName);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("El usuario ha iniciado Sesion"),
              backgroundColor: Color(0xFF36499B),
              elevation: 10,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Correo o contraseña incorrectos"),
              backgroundColor: Color(0xFF36499B),
              elevation: 10,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("El usuario no puede ser autenticado"),
            backgroundColor: Color(0xFF36499B),
            elevation: 10,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: const Color(0xFF36499B),
          elevation: 10,
        ),
      );
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Se ha enviado un correo electrónico para restablecer la contraseña.'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage =
            "El correo electrónico que ingresó no está registrado. Por favor, regístrese con un correo válido.";
      } else {
        errorMessage =
            "Error al enviar el correo electrónico de restablecimiento de contraseña: ${e.code}";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: const Color(0xFF36499B),
          elevation: 10,
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Error al enviar el correo electrónico de restablecimiento de contraseña: $error'),
        ),
      );
    }
  }
}
