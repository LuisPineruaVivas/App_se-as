import 'package:first_app/auth/firestore.dart';
import 'package:first_app/components/bottom_button.dart';
import 'package:first_app/components/drag_lesson.dart';
import 'package:first_app/components/grid_lesson.dart';
import 'package:first_app/components/lesson_app_bar.dart';
import 'package:first_app/components/list_lesson.dart';
import 'package:first_app/components/videolesson.dart';
import 'package:first_app/variables.dart';
import 'package:flutter/material.dart';

class Lesson5Screen extends StatefulWidget {
  static String routeName = "/lesson5_screen";

  const Lesson5Screen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return Lesson5ScreenState();
  }
}

class Lesson5ScreenState extends State<Lesson5Screen> {
  double percent = 0;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var lessons = [
      VideoLesson(
          const [
            'diasSemana.gif',
            'lunes.gif',
            'martes.gif',
            'miercoles.gif',
            'jueves.gif',
            'viernes.gif',
            'sabado.gif',
            'domingo.gif'
          ],
          const [
            'Días de la semana',
            'Lunes',
            'Martes',
            'Miércoles',
            'Jueves',
            'Viernes',
            'Sábado',
            'Domingo'
          ],
          "Los días de la semana en el lenguaje de señas venezolano son fundamentales "
              "para expresar eventos, horarios y planificaciones. Cada día tiene su "
              "propio gesto característico, el cual se utiliza para representar su nombre correspondiente",
          'images/Leccion5.mp4',
          'Leccion 5',
          'Los Días de la Semana',
          1,
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Viernes',
        'images/domingo.gif',
        'images/viernes.gif',
        'images/sabado.gif',
        'images/lunes.gif',
        'images/viernes.gif',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      ListLesson(
          'Traduce la siguiente seña',
          const ['Martes', 'Domingo', 'Lunes', 'Miércoles'],
          'images/miercoles.gif',
          'Miércoles',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Jueves',
        'images/sabado.gif',
        'images/lunes.gif',
        'images/martes.gif',
        'images/jueves.gif',
        'images/jueves.gif',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      DragLesson(
          'images/diasSemana.gif',
          ['Días', 'martes', 'semana', 'de', 'viernes', 'la'],
          const ['Días', 'de', 'la', 'semana'],
          checkButton: bottomButton(context, 'SIGUIENTE')),
      ListLesson(
          'Traduce la siguiente seña',
          const ['Domingo', 'Sábado', 'Lunes', 'Viernes'],
          'images/lunes.gif',
          'Lunes',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Martes',
        'images/sabado.gif',
        'images/jueves.gif',
        'images/lunes.gif',
        'images/martes.gif',
        'images/martes.gif',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      ListLesson(
          'Traduce la siguiente seña',
          const ["Domingo", 'Jueves', 'Lunes', 'Martes'],
          'images/domingo.gif',
          'Domingo',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Sábado',
        'images/sabado.gif',
        'images/viernes.gif',
        'images/jueves.gif',
        'images/martes.gif',
        'images/sabado.gif',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      ListLesson(
          'Traduce la siguiente seña',
          const ["Lunes", 'Miércoles', 'Domingo', 'Viernes'],
          'images/viernes.gif',
          'Viernes',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      DragLesson('images/martes.gif',
          ['Lunes', 'Martes', 'Jueves', 'Domingo', 'Viernes'], const ['Martes'],
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
                FirestoreDatasource.addlesson('Leccion 5', respuestas,
                    'images/dias.png', 'Dias de la semana');
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
