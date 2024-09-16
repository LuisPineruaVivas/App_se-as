import 'package:first_app/components/bottom_button.dart';
import 'package:first_app/components/drag_lesson.dart';
import 'package:first_app/components/grid_lesson.dart';
import 'package:first_app/components/lesson_app_bar.dart';
import 'package:first_app/components/list_lesson.dart';
import 'package:first_app/components/videolesson.dart';
import 'package:flutter/material.dart';

class Lesson8Screen extends StatefulWidget {
  static String routeName = "/lesson8_screen";

  static int answers = 0;
  const Lesson8Screen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return Lesson8ScreenState();
  }
}

class Lesson8ScreenState extends State<Lesson8Screen> {
  double percent = 10.0;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var lessons = [
      VideoLesson(
          const ['A.png', 'E.png', 'i.png', 'o.png', 'u.png'],
          const ['Letra A', 'Letra E', 'Letra i', 'Letra O', 'Letra U'],
          "   En el lenguaje de señas venezolano, las vocales juegan "
              "un papel fundamental en la comunicación gestual, sirviendo como ",
          'images/Leccion8.mp4',
          'Leccion 8',
          'Pronombres Personales',
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
      ListLesson(
          'Traduce la siguiente seña',
          const ['Hola', 'Buenas Noches', 'Adios', 'Buenas Tardes'],
          'images/hello.gif',
          'Hola',
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
          'images/hello.gif',
          ['Hola', 'Permiso', 'Gracias', 'Por favor', 'Adios', 'Hasta'],
          const ['Hola'],
          checkButton: bottomButton(context, 'SIGUIENTE')),
      ListLesson(
          'Traduce la siguiente seña',
          const ['Buenas Noches.', 'Gracias', 'Por favor', 'Adios'],
          'images/hello.gif',
          'Adios',
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
      ListLesson(
          'Traduce la siguiente seña',
          const ["Permiso", 'Buenos dias', 'Adios', 'Hola'],
          'images/hello.gif',
          'Hola',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      DragLesson(
          'images/hello.gif',
          ['Hola', 'Permiso', 'Gracias', 'Por favor', 'Adios', 'Hasta'],
          const ['Hola'],
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Letra U',
        'images/u.png',
        'images/o.png',
        'images/i.png',
        'images/E.png',
        'images/u.png',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      )
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return dialog('Resultado ${Lesson8Screen.answers} /10 ');
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
    Lesson8Screen.answers = 0;
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
