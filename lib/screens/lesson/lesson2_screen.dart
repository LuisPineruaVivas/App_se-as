import 'package:first_app/auth/firestore.dart';
import 'package:first_app/components/bottom_button.dart';
import 'package:first_app/components/drag_lesson.dart';
import 'package:first_app/components/grid_lesson.dart';
import 'package:first_app/components/lesson_app_bar.dart';
import 'package:first_app/components/list_lesson.dart';
import 'package:first_app/components/videolesson.dart';
import 'package:first_app/variables.dart';
import 'package:flutter/material.dart';

class Lesson2Screen extends StatefulWidget {
  static String routeName = "/lesson2_screen";

  const Lesson2Screen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return Lesson2ScreenState();
  }
}

class Lesson2ScreenState extends State<Lesson2Screen> {
  double percent = 0;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var lessons = [
      VideoLesson(const [
        'A.png',
        'b.png',
        'c.png',
        'd.png',
        'E.png',
        'f.png',
        'g.gif',
        'h.png',
        'i.png',
        'j.gif',
        'k.png',
        'l.png',
        'm.png',
        'n.png',
        'ñ.gif',
        'o.png',
        'p.gif',
        'q.png',
        'r.png',
        's.gif',
        't.png',
        'u.png',
        'v.png',
        'w.png',
        'x.png',
        'y.png',
        'z.gif',
      ], const [
        'Letra A',
        'Letra B',
        'Letra C',
        'Letra D',
        'Letra E',
        'Letra F',
        'Letra G',
        'Letra H',
        'Letra I',
        'Letra J',
        'Letra K',
        'Letra L',
        'Letra M',
        'Letra N',
        'Letra Ñ',
        'Letra O',
        'Letra P',
        'Letra Q',
        'Letra R',
        'Letra S',
        'Letra T',
        'Letra U',
        'Letra V',
        'Letra W',
        'Letra X',
        'Letra Y',
        'Letra Z'
      ], 'El abecedario en el lenguaje de señas venezolano es un aspecto fundamental para la comunicación gestual efectiva. Cada letra del alfabeto se representa mediante gestos específicos, los cuales son la base para formar palabras y expresar ideas',
          'images/Leccion2.mp4', 'Leccion 2', 'El Abcedario', 1,
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Letra P',
        'images/p.gif',
        'images/s.gif',
        'images/w.png',
        'images/b.png',
        'images/p.gif',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      ListLesson('Cual es la siguiente seña', const ['H', 'X', 'Z', 'K'],
          'images/z.gif', 'Z',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Letra Q',
        'images/r.png',
        'images/v.png',
        'images/m.png',
        'images/q.png',
        'images/q.png',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      DragLesson('images/p.gif', ['P', 'R', 'Q', 'S', 'M', 'L'], const ['L'],
          checkButton: bottomButton(context, 'SIGUIENTE')),
      ListLesson('Cual es la siguiente seña', const ['D', 'F', 'C', 'H'],
          'images/f.png', 'F',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Letra N',
        'images/n.png',
        'images/ñ.gif',
        'images/x.png',
        'images/w.png',
        'images/n.png',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      ListLesson('Cual es la siguiente seña', const ["Y", 'X', 'W', 'Z'],
          'images/z.gif', 'Z',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      DragLesson('images/t.png', ['V', 'N', 'S', 'W', 'O', 'T'], const ['T'],
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Letra K',
        'images/k.png',
        'images/j.gif',
        'images/b.png',
        'images/l.png',
        'images/k.png',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      ListLesson('Cual es la siguiente seña', const ["M", 'P', 'N', 'S'],
          'images/s.gif', 'S',
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
                FirestoreDatasource.addlesson(
                    'Leccion 2', respuestas, 'images/abc.png', 'El Abcedario');
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
