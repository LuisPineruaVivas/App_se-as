import 'package:first_app/auth/firestore.dart';
import 'package:first_app/components/bottom_button.dart';
import 'package:first_app/components/drag_lesson.dart';
import 'package:first_app/components/grid_lesson.dart';
import 'package:first_app/components/lesson_app_bar.dart';
import 'package:first_app/components/list_lesson.dart';
import 'package:first_app/components/videolesson.dart';
import 'package:first_app/variables.dart';
import 'package:flutter/material.dart';

class Lesson6Screen extends StatefulWidget {
  static String routeName = "/lesson6_screen";

  const Lesson6Screen({super.key});
  @override
  State<StatefulWidget> createState() {
    return Lesson6ScreenState();
  }
}

class Lesson6ScreenState extends State<Lesson6Screen> {
  double percent = 0;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var lessons = [
      VideoLesson(const [
        'necesitasAyuda.gif',
        'tesientesmal.gif',
        'quesientes.gif',
        'dondeteduele.gif',
        'mesientomal.gif',
        'mesientobien.gif',
        'sientodolor.gif',
        'necesitoayuda.gif',
        'estoyenfermo.gif',
        'enfermera.gif',
        'emergencia.gif',
        'hospital.gif',
        'medico.gif',
        'ambulancia.gif',
        'medicina.gif'
      ], const [
        'Necesitas Ayuda',
        '¿Te sientes mal?',
        '¿Qué sientes?',
        '¿Dónde te duele?',
        'Me siento mal',
        'Me siento bien',
        'Siento Dolor',
        'Necesito Ayuda',
        'Estoy Enfermo',
        'Enfermera',
        'Emergencia',
        'Hospital',
        'Médico',
        'Ambulancia',
        'Medicina'
      ], "   La comunicación efectiva en situaciones de ayuda y asistencia médica es crucial para garantizar la atención adecuada de las personas sordas. En la lengua de señas venezolana, existen signos específicos para términos médicos, síntomas y acciones relacionadas con el cuidado de la salud. Aprender estas señas facilita la interacción entre pacientes y profesionales de la salud, asegurando que las necesidades médicas sean comprendidas con precisión",
          'images/Leccion6.mp4', 'Lección 6', 'Asistencia Medica', 2,
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
          '¿Te sientes mal?',
          'images/dondeteduele.gif',
          'images/tesientesmal.gif',
          'images/medicina.gif',
          'images/estoyenfermo.gif',
          'images/tesientesmal.gif',
          checkButton: bottomButton(context, 'SIGUIENTE'),
          2),
      ListLesson(
          'Traduce la siguiente seña',
          const ['Enfermera', 'Ambulancia', 'Hospital', 'Medico'],
          'images/medico.gif',
          'Medico',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
          'Diciembre',
          'images/ambulancia.gif',
          'images/julio.gif',
          'images/diciembre.gif',
          'images/octubre.gif',
          'images/diciembre.gif',
          checkButton: bottomButton(context, 'SIGUIENTE'),
          2),
      DragLesson(
          'images/enero.gif',
          ['Abril', 'Junio', 'Diciembre', 'Enero', 'Mayo', 'Agosto'],
          const ['Enero'],
          checkButton: bottomButton(context, 'SIGUIENTE')),
      ListLesson(
          'Traduce la siguiente seña',
          const ['Octubre', 'Julio', 'Marzo', 'Febrero'],
          'images/marzo.gif',
          'Marzo',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
          'Julio',
          'images/julio.gif',
          'images/agosto.gif',
          'images/enero.gif',
          'images/febrero.gif',
          'images/julio.gif',
          checkButton: bottomButton(context, 'SIGUIENTE'),
          2),
      ListLesson(
          'Traduce la siguiente seña',
          const ["Diciembre", 'Agosto', 'Febrero', 'Noviembre'],
          'images/febrero.gif',
          'Febrero',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      DragLesson('images/noviembre.gif',
          ['Diciembre', 'Noviembre', 'Febrero', 'Octubre'], const ['Noviembre'],
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
          'Mayo',
          'images/julio.gif',
          'images/septiembre.gif',
          'images/enero.gif',
          'images/mayo.gif',
          'images/mayo.gif',
          checkButton: bottomButton(context, 'SIGUIENTE'),
          2),
      ListLesson(
          'Traduce la siguiente seña',
          const ["Febrero", 'Septiembre', 'Enero', 'Marzo'],
          'images/marzo.gif',
          'Marzo',
          checkButton: bottomButton(context, 'SIGUIENTE')),
    ];

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
                percent += 10;
                index++;
              } else {
                FirestoreDatasource.addlesson('Leccion 6', respuestas,
                    'images/meses.png', 'Meses del Año');
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return dialog('Resultado $respuestas /10 ');
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
}
