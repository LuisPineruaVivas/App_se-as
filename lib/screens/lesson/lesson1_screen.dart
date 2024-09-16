import 'package:first_app/auth/firestore.dart';
import 'package:first_app/components/bottom_button.dart';
import 'package:first_app/components/drag_lesson.dart';
import 'package:first_app/components/grid_lesson.dart';
import 'package:first_app/components/lesson_app_bar.dart';
import 'package:first_app/components/list_lesson.dart';
import 'package:first_app/components/videolesson.dart';
import 'package:first_app/variables.dart';
import 'package:flutter/material.dart';

class Lesson1Screen extends StatefulWidget {
  static String routeName = "/lesson_screen";

  const Lesson1Screen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return Lesson1ScreenState();
  }
}

class Lesson1ScreenState extends State<Lesson1Screen> {
  double percent = 0;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var lessons = [
      VideoLesson(
          const ['A.png', 'E.png', 'i.png', 'o.png', 'u.png'],
          const ['Letra A', 'Letra E', 'Letra i', 'Letra O', 'Letra U'],
          "   En el lenguaje de señas venezolano, las vocales juegan "
              "un papel fundamental en la comunicación gestual, sirviendo como "
              "bloques de construcción esenciales para transmitir significados "
              "precisos. Aprender a representar correctamente las vocales en el "
              "lenguaje de señas es crucial para garantizar la claridad y "
              "comprensión de los mensajes. La práctica regular es fundamental "
              "para mejorar la fluidez y la precisión en la realización de estos gestos.",
          'images/Leccion1.mp4',
          'Leccion 1',
          'Las Vocales',
          1,
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Letra A',
        'images/E.png',
        'images/A.png',
        'images/o.png',
        'images/i.png',
        'images/A.png',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      ListLesson('Traduce la siguiente seña', const ['U', 'E', 'I', 'O'],
          'images/u.png', 'U',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Letra O',
        'images/o.png',
        'images/E.png',
        'images/A.png',
        'images/i.png',
        'images/o.png',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      DragLesson(
          'images/u.png', ['A', 'O', 'Vocales', 'I', 'U', 'E'], const ['U'],
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Letra I',
        'images/i.png',
        'images/E.png',
        'images/A.png',
        'images/u.png',
        'images/i.png',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      ListLesson('Traduce la siguiente seña', const ['U', 'O', 'A', 'I'],
          'images/o.png', 'O',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Letra U',
        'images/u.png',
        'images/o.png',
        'images/i.png',
        'images/E.png',
        'images/u.png',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      ListLesson('Traduce la siguiente seña', const ["E", 'A', 'O', 'I'],
          'images/i.png', 'I',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Letra A',
        'images/u.png',
        'images/A.png',
        'images/i.png',
        'images/E.png',
        'images/A.png',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      ListLesson('Traduce la siguiente seña', const ["U", 'I', 'A', 'E'],
          'images/u.png', 'U',
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
                FirestoreDatasource.addlesson('Leccion 1', respuestas,
                    'images/vocales.png', 'Las Vocales');
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
