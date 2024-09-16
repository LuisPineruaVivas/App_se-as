import 'package:first_app/auth/firestore.dart';
import 'package:first_app/components/bottom_button.dart';
import 'package:first_app/components/drag_lesson.dart';
import 'package:first_app/components/grid_lesson.dart';
import 'package:first_app/components/lesson_app_bar.dart';
import 'package:first_app/components/list_lesson.dart';
import 'package:first_app/components/videolesson.dart';
import 'package:first_app/variables.dart';
import 'package:flutter/material.dart';

class Lesson3Screen extends StatefulWidget {
  static String routeName = "/lesson3_screen";

  const Lesson3Screen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return Lesson3ScreenState();
  }
}

class Lesson3ScreenState extends State<Lesson3Screen> {
  double percent = 0;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var lessons = [
      VideoLesson(
          const [
            'colores.gif',
            'amarillo.gif',
            'azul.gif',
            'blanco.gif',
            'dorado.gif',
            'marron.gif',
            'morado.gif',
            'naranja.gif',
            'negro.gif',
            'plateado.gif',
            'rojo.gif',
            'verde.gif'
          ],
          const [
            'Colores',
            'Color Amarillo',
            'Color Azul',
            'Color Blanco',
            'Color Dorado',
            'Color Marron',
            'Color Morado',
            'Color Naranja',
            'Color Negro',
            'Color Plateado',
            'Color Rojo',
            'Color Verde'
          ],
          "   En el lenguaje de señas venezolano, las vocales juegan "
              "un papel fundamental en la comunicación gestual, sirviendo como ",
          'images/Leccion3.mp4',
          'Leccion 3',
          'Los Colores',
          1,
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Color Morado',
        'images/morado.gif',
        'images/amarillo.gif',
        'images/verde.gif',
        'images/azul.gif',
        'images/morado.gif',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      ListLesson(
          'Traduce la siguiente seña',
          const ['Verde', 'Dorado', 'Plateado', 'Negro'],
          'images/verde.gif',
          'Verde',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Color Negro',
        'images/blanco.gif',
        'images/dorado.gif',
        'images/marron.gif',
        'images/negro.gif',
        'images/negro.gif',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      DragLesson(
          'images/plateado.gif',
          ['Blanco', 'Dorado', 'Naranja', 'Plateado', 'Verde'],
          const ['Plateado'],
          checkButton: bottomButton(context, 'SIGUIENTE')),
      ListLesson(
          'Traduce la siguiente seña',
          const ['Naranja', 'Morado', 'Blanco', 'Marron'],
          'images/marron.gif',
          'Marron',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Color Amarillo',
        'images/verde.gif',
        'images/rojo.gif',
        'images/amarillo.gif',
        'images/azul.gif',
        'images/amarillo.gif',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      ListLesson('Traduce la siguiente seña',
          const ["Azul", 'Verde', 'Blanco', 'Negro'], 'images/azul.gif', 'Azul',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      DragLesson(
          'images/naranja.gif',
          ['Naranja', 'Azul', 'Dorado', 'Rojo', 'Verde', 'Plateado'],
          const ['Naranja'],
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Color Dorado',
        'images/dorado.gif',
        'images/verde.gif',
        'images/rojo.gif',
        'images/verde.gif',
        'images/dorado.gif',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      ListLesson(
          'Traduce la siguiente seña',
          const ["Rojo", 'Morado', 'Blanco', 'Amarillo'],
          'images/amarillo.gif',
          'Amarillo',
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
                FirestoreDatasource.addlesson('Leccion 3', respuestas,
                    'images/colores.png', 'Los colores');
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
