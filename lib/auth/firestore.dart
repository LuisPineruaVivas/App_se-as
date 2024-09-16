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
      print('Error: $e');
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
}
