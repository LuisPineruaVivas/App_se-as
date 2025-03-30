import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/components/bottom_button.dart';
import 'package:first_app/components/lesson_app_bar.dart';
import 'package:first_app/components/sign_evaluation.dart';
import 'package:first_app/variables.dart';
import 'package:flutter/material.dart';

class Evaluation1Screen extends StatefulWidget {
  static String routeName = "/evaluation1_screen";

  const Evaluation1Screen({super.key});

  @override
  State<StatefulWidget> createState() {
    return Evaluation1ScreenState();
  }
}

class Evaluation1ScreenState extends State<Evaluation1Screen> {
  double percent = 0;
  int index = 0;
  List<String> letters = ['A', 'E', 'I', 'O', 'U'];
  List<String> randomLetters = [];
  bool isEvaluating = true;

  @override
  void initState() {
    super.initState();
    // Inicializamos respuestas en 0 cuando se inicie la evaluación.
    resetEvaluation();
  }

  @override
  Widget build(BuildContext context) {
    var lessons = List.generate(
      5, // Solo 5 evaluaciones
      (i) => SignEvaluation('Realiza la seña de la letra ${randomLetters[i]}',
          letters, randomLetters[i], '', '',
          checkButton: bottomButton(context, 'SIGUIENTE')),
    );

    return Scaffold(
      appBar: LessonAppBar(percent: percent),
      body: lessons[index],
    );
  }

  bottomButton(BuildContext context, String title) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              if (percent <= 99) {
                percent += 25;
                index++;
              } else {
                saveResultsToFirebase();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return dialog('Resultado $respuestas /5');
                  },
                );
              }
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 0, 105, 155),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  dialog(String title) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 120,
        width: double.infinity,
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            dialogTitle(title),
            BottomButton(context, title: 'CONTINUE'),
          ],
        ),
      ),
    );
  }

  dialogTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.only(left: 15),
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 27, 97, 129),
          ),
          child: Text(text),
        ),
      ),
    );
  }

  // Método para reiniciar la evaluación cuando se empieza una nueva.
  void resetEvaluation() {
    setState(() {
      percent = 0;
      index = 0;
      randomLetters = List.from(letters)..shuffle(Random());
      isEvaluating = true;
    });
  }

  // Obtener el UID del usuario actual de FirebaseAuth
  String get userId {
    final user = FirebaseAuth.instance.currentUser;
    return user != null
        ? user.uid
        : ''; // Devuelve el UID del usuario autenticado
  }

  Future<void> saveResultsToFirebase() async {
    try {
      // Buscar si ya existe una evaluación para este usuario y evaluación (Evaluacion 1)
      var evaluationSnapshot = await FirebaseFirestore.instance
          .collection('users') // Colección de usuarios
          .doc(userId) // Documento del usuario actual
          .collection('evaluation') // Subcolección 'evaluation'
          .where('title', isEqualTo: 'Evaluacion 1') // Filtramos por título
          .get();

      if (evaluationSnapshot.docs.isEmpty) {
        // Si no existe, creamos una nueva evaluación
        final newEvaluationId =
            FirebaseFirestore.instance.collection('evaluation').doc().id;
        final newResults = {
          "imagen": "images/vocales.png",
          "respuestas": respuestas,
          "subtitle": "Las Vocales",
          "title": "Evaluacion 1",
          "Fecha de realizacion": Timestamp.now(),
        };

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('evaluation')
            .doc(newEvaluationId)
            .set(newResults); // Guarda la nueva evaluación
      } else {
        // Si ya existe, actualizamos la evaluación existente
        var docId = evaluationSnapshot.docs.first.id;
        final updatedResults = {
          "imagen": "images/vocales.png",
          "respuestas": respuestas,
          "subtitle": "Las Vocales",
          "title": "Evaluacion 1",
          "Date": Timestamp.now(),
        };

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('evaluation')
            .doc(docId)
            .update(updatedResults); // Actualiza la evaluación existente
      }
    } catch (e) {
      print("Error saving/updating results to Firebase: $e");
    }
  }
}
