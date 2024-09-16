// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/auth/auth.dart';
import 'package:first_app/models/jsons/student.dart';
import 'package:first_app/models/provider/student_provider.dart';
import 'package:flutter/material.dart';

class SignUpController {
  late BuildContext context;
  late Function refresh;

  TextEditingController nombre = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController contrasena = TextEditingController();

  late AuthAppProvider _auth;
  late StudentProvider _student;

  final user = FirebaseAuth.instance;

  bool obscureText = true;

  final formSignupKey = GlobalKey<FormState>();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    _auth = AuthAppProvider();
    _student = StudentProvider();
  }

  register() async {
    if (nombre.text.isEmpty &&
        correo.text.trim().isEmpty &&
        contrasena.text.trim().isEmpty) {
      return;
    }

    try {
      bool isRegister =
          await _auth.register(correo.text.trim(), contrasena.text.trim());

      if (isRegister) {
        Student student = Student(
          id: _auth.getUser()!.uid,
          nombre: nombre.text.trim(),
          correo: _auth.getUser()!.email!,
          contrasena: contrasena.text.trim(),
        );

        await _student.create(student);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: const Color(0xFF36499B),
          elevation: 10,
        ),
      );
      refresh();
    }

    refresh();
  }

  void mostrarDialogCorreoExistente() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Correo Existente'),
          content: const Text(
              'El correo ingresado ya está registrado. Por favor, inicia sesión.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void contrasenavisible() {
    obscureText = !obscureText;
    refresh();
  }
}
