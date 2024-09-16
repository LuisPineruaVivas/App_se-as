import 'package:first_app/auth/firestore.dart';
import 'package:first_app/components/bottom_button.dart';
import 'package:first_app/components/drag_lesson.dart';
import 'package:first_app/components/grid_lesson.dart';
import 'package:first_app/components/lesson_app_bar.dart';
import 'package:first_app/components/list_lesson.dart';
import 'package:first_app/components/videolesson.dart';
import 'package:first_app/variables.dart';
import 'package:flutter/material.dart';

class Lesson4Screen extends StatefulWidget {
  static String routeName = "/lesson4_screen";

  const Lesson4Screen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return Lesson4ScreenState();
  }
}

class Lesson4ScreenState extends State<Lesson4Screen> {
  double percent = 0;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var lessons = [
      VideoLesson(
          const [
            '1.gif',
            '2.gif',
            '3.gif',
            '4.gif',
            '5.gif',
            '6.gif',
            '7.gif',
            '8.gif',
            '9.gif',
            '10.gif',
            '100.gif',
            '1000.gif',
            '1.000.000.gif'
          ],
          const [
            'Numero 1',
            'Numero 2',
            'Numero 3',
            'Numero 4',
            'Numero 5',
            'Numero 6',
            'Numero 7',
            'Numero 8',
            'Numero 9',
            'Numero 10',
            'Numero 100',
            'Numero 1.000',
            'Numero 1.000.000'
          ],
          "Los números en el lenguaje de señas venezolano son elementos cruciales "
              "para expresar cantidades, fechas, y otros conceptos numéricos de manera clara y precisa."
              "Cada número tiene su propio gesto distintivo, el cual se utiliza para representar su valor correspondiente",
          'images/Leccion4.mp4',
          'Leccion 4',
          'Los Numeros',
          1,
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Numero 7',
        'images/3.gif',
        'images/1.gif',
        'images/7.gif',
        'images/9.gif',
        'images/7.gif',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      ListLesson(
          'Traduce la siguiente seña',
          const ['Numero 1', 'Numero 5', 'Numero 4', 'Numero 2'],
          'images/1.gif',
          'Numero 1',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Numero 10',
        'images/10.gif',
        'images/100.gif',
        'images/1000.gif',
        'images/1.gif',
        'images/10.gif',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      DragLesson(
          'images/2.gif',
          ['Numero 1', 'Numero 5', 'Numero 7', 'Numero 10', 'Numero 2'],
          const ['Numero 2'],
          checkButton: bottomButton(context, 'SIGUIENTE')),
      ListLesson(
          'Traduce la siguiente seña',
          const ['Numero 8', 'Numero 1', 'Numero 3', 'Numero 2'],
          'images/3.gif',
          'Numero 3',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Numero 4',
        'images/1.gif',
        'images/5.gif',
        'images/9.gif',
        'images/4.gif',
        'images/4.gif',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      ListLesson(
          'Traduce la siguiente seña',
          const ["Numero 1", 'Numero 3', 'Numero 10', 'Numero 7'],
          'images/1.gif',
          'Numero 1',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Numero 8',
        'images/7.gif',
        'images/8.gif',
        'images/9.gif',
        'images/100.gif',
        'images/8.gif',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      ListLesson(
          'Traduce la siguiente seña',
          const ["Numero 100", 'Numero 10', 'Numero 1.000', 'Numero 1.000.000'],
          'images/100.gif',
          'Numero 100',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Numero 100',
        'images/100.gif',
        'images/10.gif',
        'images/5.gif',
        'images/1.gif',
        'images/100.gif',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
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
                FirestoreDatasource.addlesson(
                    'Leccion 4', respuestas, 'images/numeros.png', 'Numeros');
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
