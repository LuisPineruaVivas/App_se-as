// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/models/jsons/student.dart';

class StudentProvider {
  late CollectionReference _ref;

  StudentProvider() {
    _ref = FirebaseFirestore.instance.collection('users');
  }

  Future<void> create(Student student) async {
    try {
      return _ref.doc(student.id).set(student.toJson());
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Stream<DocumentSnapshot> getByIdStream(String id) {
    return _ref.doc(id).snapshots(includeMetadataChanges: true);
  }

  Future<Student?> getById(String id) async {
    DocumentSnapshot document = await _ref.doc(id).get();

    if (document.exists) {
      Student student =
          Student.fromJson(document.data() as Map<String, dynamic>);
      return student;
    }
    return null;
  }

  Future<void> update(Map<String, dynamic> data, String id) {
    return _ref.doc(id).update(data);
  }

  Future<void> delete(String id) {
    return _ref.doc(id).delete();
  }
}
