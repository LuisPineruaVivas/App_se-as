// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/auth/auth.dart';
import 'package:first_app/models/jsons/student.dart';
import 'package:first_app/models/provider/student_provider.dart';
import 'package:first_app/screens/welcome/welcome.dart';
import 'package:flutter/material.dart';

class PerfilController {
  late BuildContext context;
  late Function refresh;

  late AuthAppProvider _auth;
  late StudentProvider _student;

  Student? student;

  final user = FirebaseAuth.instance;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    _auth = AuthAppProvider();
    _student = StudentProvider();

    getUserInfo();
  }

  void getUserInfo() async {
    Stream<DocumentSnapshot> userStream =
        _student.getByIdStream(_auth.getUser()!.uid);
    userStream.listen(
      (DocumentSnapshot document) {
        student = Student.fromJson(document.data() as Map<String, dynamic>);
        refresh();
      },
    );
  }

  void signOut() async {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      ),
    );
  }
}
