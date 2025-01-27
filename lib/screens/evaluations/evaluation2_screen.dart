import 'dart:math';
import 'package:first_app/components/sign_evaluation2.dart';
import 'package:first_app/components/lesson_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Evaluation2Screen extends StatefulWidget {
  static String routeName = "/evaluation2_screen";

  const Evaluation2Screen({super.key});

  @override
  _Evaluation2ScreenState createState() => _Evaluation2ScreenState();
}

class _Evaluation2ScreenState extends State<Evaluation2Screen> {
  double percent = 0;
  int index = 0;
  int correctAnswers = 0;
  List<String> letters = ['A', 'E', 'I', 'O', 'U'];
  List<String> randomLetters = [];
  bool isEvaluating = true;

  @override
  void initState() {
    super.initState();
    resetEvaluation(); // Llamamos a resetEvaluation cuando entramos a esta pantalla
  }

  void resetEvaluation() {
    setState(() {
      percent = 0;
      index = 0;
      correctAnswers = 0;
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

  // Guardar o actualizar resultados en Firestore con un ID único
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
          "respuestas": correctAnswers,
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
          "respuestas": correctAnswers,
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

  @override
  Widget build(BuildContext context) {
    var lessons = List.generate(
      2, // Solo 2 evaluaciones
      (i) => SignEvaluation2(
        'Realiza la seña de la letra ${randomLetters[i]}',
        letters,
        randomLetters[i],
        onSenaCorrecta: _onCorrectAnswer,
        onSenaIncorrecta: _onIncorrectAnswer,
      ),
    );

    return WillPopScope(
      onWillPop: () async {
        // Evitar regresar al flujo anterior
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        return false;
      },
      child: Scaffold(
        appBar: LessonAppBar(percent: percent),
        body: isEvaluating
            ? (index < lessons.length
                ? lessons[index]
                : const Center(
                    child: Text(
                      'Error: Índice fuera de rango',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  ))
            : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Resultado: $correctAnswers/2 Correctas',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 27, 97, 129),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _onCorrectAnswer() {
    setState(() {
      correctAnswers++;
      _advanceEvaluation();
    });
  }

  void _onIncorrectAnswer() {
    setState(() {
      _advanceEvaluation();
    });
  }

  void _advanceEvaluation() {
    if (index < 1) {
      // Maneja la evaluación de 2 preguntas
      index++;
      percent = (index + 1) / 2; // Actualiza el progreso
    } else {
      isEvaluating = false; // Finaliza la evaluación
      saveResultsToFirebase(); // Guarda o actualiza los resultados en Firebase
      Future.delayed(Duration(seconds: 2), () {
        // Espera 2 segundos antes de redirigir al home
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
        );
      });
    }
  }
}
