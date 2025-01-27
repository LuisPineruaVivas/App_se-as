import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FirestoreDatasource {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<bool> addlesson(
      String lesson, int num, String image, String subtitle) async {
    try {
      var querySnapshot = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('lessons')
          .where('title', isEqualTo: lesson)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var docId = querySnapshot.docs.first.id;
        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection('lessons')
            .doc(docId)
            .update({'respuestas': num});
      } else {
        var uuid = const Uuid().v4();
        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection('lessons')
            .doc(uuid)
            .set({
          'id': uuid,
          'title': lesson,
          'respuestas': num,
          'imagen': image,
          'subtitle': subtitle,
        });
      }
      return true;
    } catch (e) {
      //print('Error: $e');
      return false;
    }
  }

  static Stream<List<Map<String, dynamic>>> lessons() {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('lessons')
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.docs.map((doc) => doc.data()).toList());
  }

  static Stream<List<Map<String, dynamic>>> evaluations() {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('evaluation')
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.docs.map((doc) => doc.data()).toList());
  }

  //funcion obtener usuarios
  static Stream<List<Map<String, dynamic>>> users() {
    return _firestore.collection('users').snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((doc) => doc.data()).toList());
  }

  // Función para obtener los datos de un documento por ID en formato de Stream
  static Stream<Map<String, dynamic>?> userData() {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .snapshots()
        .map((doc) => doc.data()!);
  }

  // Función para obtener los datos de un documento por ID en formato de json
  static Future<Map<String, dynamic>?> userDataJson() async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await _firestore.collection('users').doc(_auth.currentUser!.uid).get();

    return doc.data();
  }

  static Future<void> updateAcceptCalls(bool status) async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .update({'acceptCalls': status});
  }

  static Future<bool> addEvaluation(
      String evaluation, int num, String image, String subtitle) async {
    try {
      var querySnapshot = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('evaluations')
          .where('title', isEqualTo: evaluation)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var docId = querySnapshot.docs.first.id;
        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection('evaluations')
            .doc(docId)
            .update({'nota': num});
      } else {
        var uuid = const Uuid().v4();
        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection('evaluations')
            .doc(uuid)
            .set({
          'id': uuid,
          'title': evaluation,
          'nota': num,
          'imagen': image,
          'subtitle': subtitle,
        });
      }
      return true;
    } catch (e) {
      //print('Error: $e');
      return false;
    }
  }
}
