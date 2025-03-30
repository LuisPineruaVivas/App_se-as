import 'package:first_app/screens/evaluations/evaluation1_screen.dart';
import 'package:first_app/screens/evaluations/evaluation2_screen.dart';
import 'package:first_app/screens/evaluations/evaluation_widget.dart';
import 'package:first_app/variables.dart';
import 'package:flutter/material.dart';

class EvaluationScreen extends StatefulWidget {
  static String routeName = "/evaluations";

  const EvaluationScreen({super.key});
  @override
  State<EvaluationScreen> createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends State<EvaluationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            EvaluationWidget(
              'Evaluación 1',
              'Las Vocales',
              'images/vocales.png',
              true,
              onPressed: () {
                setState(() {
                  respuestas = 0;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Evaluation1Screen()));
              },
            ),
            EvaluationWidget(
              'Evaluación 2',
              'El Abecedario',
              'images/abc.png',
              true,
              onPressed: () {
                setState(() {
                  respuestas = 0;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Evaluation2Screen()));
              },
            )
            /* 
            const EvaluationWidget(
                'Evaluación 3', 'Los Colores', 'images/colores.png', false),*/
            /*const EvaluationWidget(
                'Evaluacion 4', 'Las Numeros', 'images/numeros.png', false),
            const EvaluationWidget('Evaluacion 5', 'Las Dias de la Semana',
                'images/dias.png', false),
            const EvaluationWidget(
                'Evaluacion 6', 'Los Meses del Año', 'images/meses.png', false),*/
          ],
        ),
      )),
    );
  }
}
