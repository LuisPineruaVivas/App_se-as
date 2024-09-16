import 'package:first_app/components/bottom_button.dart';
import 'package:first_app/components/drag_lesson.dart';
import 'package:first_app/components/grid_lesson.dart';
import 'package:first_app/components/lesson_app_bar.dart';
import 'package:first_app/components/list_lesson.dart';
import 'package:first_app/components/videolesson.dart';
import 'package:flutter/material.dart';

class Lesson7Screen extends StatefulWidget {
  static String routeName = "/lesson7_screen";

  static int answers = 0;
  const Lesson7Screen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return Lesson7ScreenState();
  }
}

class Lesson7ScreenState extends State<Lesson7Screen> {
  double percent = 10.0;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var lessons = [
      VideoLesson(
          const [
            'saludo.gif',
            'hola.gif',
            'adios.gif',
            'buenosdias.gif',
            'buenastardes.gif',
            'buenasnoches.gif',
            'bienvenido.gif',
            'porfavor.gif',
            'gracias.gif',
            'buenprovecho.gif',
            'alaorden.gif',
            'perdon.gif',
            'permiso.gif'
          ],
          const [
            'Saludo',
            'Hola',
            'Adios',
            'Buenos Dias',
            'Buenas Tardes',
            'Buenas Noches',
            'Bienvenido',
            'Por favor',
            'Gracias',
            'Buen Provecho',
            'A la orden',
            'Perdon',
            'Permiso'
          ],
          "   Las normas de cortesía y los saludos en el lenguaje de señas venezolano  "
              "son fundamentales para establecer conexiones positivas y respetuosas  "
              "en la comunicación. Cada gesto de saludo tiene su propia forma distintiva, "
              "que se utiliza para expresar amabilidad y consideración hacia los demás. Practicar "
              "regularmente estos gestos es esencial para dominar su ejecución precisa y asegurar una interacción fluida y armoniosa.",
          'images/Leccion7.mp4',
          'Leccion 7',
          'Saludos',
          2,
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Permiso',
        'images/perdon.gif',
        'images/porfavor.gif',
        'images/hola.gif',
        'images/permiso.gif',
        'images/permiso.gif',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      ListLesson(
          'Traduce la siguiente seña',
          const ['Hola', 'Buenas Noches', 'Adios', 'Buenas Tardes'],
          'images/buenasnoches.gif',
          'Hola',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Buenos Dias',
        'images/buenosdias.gif',
        'images/buenastardes.gif',
        'images/buenasnoches.gif',
        'images/permiso.gif',
        'images/buenosdias.gif',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      DragLesson('images/adios.gif',
          ['Hola', 'Permiso', 'Gracias', 'Por favor', 'Adios'], const ['Adios'],
          checkButton: bottomButton(context, 'SIGUIENTE')),
      ListLesson(
          'Traduce la siguiente seña',
          const ['Buenas Noches.', 'Gracias', 'Por favor', 'Adios'],
          'images/gracias.gif',
          'Adios',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'A la orden',
        'images/alaorden.gif',
        'images/gracias.gif',
        'images/permiso.gif',
        'images/perdon.gif',
        'images/alaorden.gif',
        checkButton: bottomButton(context, 'SIGUIENTE'),
      ),
      ListLesson(
          'Traduce la siguiente seña',
          const ["Permiso", 'Buenos dias', 'Adios', 'Hola'],
          'images/permiso.gif',
          'Hola',
          checkButton: bottomButton(context, 'SIGUIENTE')),
      DragLesson(
          'images/gracias.gif',
          [
            'Buenas',
            'Noches',
            'Dias',
            'Permiso',
            'Gracias',
          ],
          const ['Gracias'],
          checkButton: bottomButton(context, 'SIGUIENTE')),
      GridLesson(
        'Buen Provecho',
        'images/buenasnoches.gif',
        'images/bienvenido.gif',
        'images/adios.gif',
        'images/buenprovecho.gif',
        'images/buenprovecho.gif',
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
                    return dialog('Resultado ${Lesson7Screen.answers} /10 ');
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
    Lesson7Screen.answers = 0;
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
