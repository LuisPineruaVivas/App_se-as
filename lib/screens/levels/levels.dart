import 'dart:math';
import 'package:first_app/screens/lesson/lesson1_screen.dart';
import 'package:first_app/screens/lesson/lesson2_screen.dart';
import 'package:first_app/screens/lesson/lesson3_screen.dart';
import 'package:first_app/screens/lesson/lesson4_screen.dart';
import 'package:first_app/screens/lesson/lesson5_screen.dart';
import 'package:first_app/screens/lesson/lesson6_screen.dart';
import 'package:first_app/variables.dart';
//import 'package:first_app/screens/lesson/lesson7_screen.dart';
// import 'package:first_app/screens/lesson/lesson8_screen.dart';
import 'package:flutter/material.dart';

class LevelsScreen extends StatefulWidget {
  static String routeName = "/levels";

  const LevelsScreen({super.key});
  @override
  State<LevelsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 105, 155),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 1.7,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  'images/Vnzla.png',
                  height: 30,
                ),
                appBarItem('images/offFire.png', '0', Colors.grey),
                appBarItem('images/crown.png', '0', Colors.grey),
              ],
            )),
        body: Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            ListView(children: <Widget>[
              const SizedBox(
                height: 15,
              ),
              twoLessons(
                  lesson(
                      'images/vocales.png', '1', 'Leccion 1', Colors.green, 1),
                  lesson('images/abc.png', '0', 'Leccion 2', Colors.red, 2)),
              const SizedBox(height: 15),
              lesson('images/colores.png', '4', 'Leccion 3', Colors.green, 3),
              const SizedBox(
                height: 15,
              ),
              twoLessons(
                  lesson(
                      'images/numeros.png', '3', 'Leccion 4', Colors.teal, 4),
                  lesson(
                      'images/dias.png', '1', 'Leccion 5', Colors.orange, 5)),
              const SizedBox(height: 15),
              lesson('images/meses.png', '0', 'Leccion 6', Colors.teal, 6),
            ]),
          ],
        ));
  }

  Widget appBarItem(String image, String num, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          image,
          height: 30,
        ),
        Text(
          num,
          style: TextStyle(color: color, fontSize: 16),
        ),
      ],
    );
  }

  Widget lesson(
      String image, String number, String title, Color color, int lesson) {
    return InkWell(
      onTap: () {
        if (lesson == 1) {
          setState(() {
            respuestas = 0;
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Lesson1Screen()));
        }
        if (lesson == 2) {
          setState(() {
            respuestas = 0;
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Lesson2Screen()));
        }
        if (lesson == 3) {
          setState(() {
            respuestas = 0;
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Lesson3Screen()));
        }
        if (lesson == 4) {
          setState(() {
            respuestas = 0;
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Lesson4Screen()));
        }
        if (lesson == 5) {
          setState(() {
            respuestas = 0;
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Lesson5Screen()));
        }
        if (lesson == 6) {
          setState(() {
            respuestas = 0;
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Lesson6Screen()));
        }
        //if (lesson == 7) {
        //  Navigator.push(context,
        //      MaterialPageRoute(builder: (context) => const Lesson7Screen()));
        //}
        // if (lesson == 8) {
        //   Navigator.push(context,
        //       MaterialPageRoute(builder: (context) => const Lesson8Screen()));
        // }
      },
      child: Column(children: <Widget>[
        Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Stack(alignment: Alignment.center, children: <Widget>[
              Transform.rotate(
                angle: 3 * pi / 4,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[300],
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.yellow),
                  value: double.parse(number) / 5,
                  strokeWidth: 60,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 42,
                ),
              ),
              CircleAvatar(
                radius: 35,
                backgroundColor: color,
                child: Image.asset(
                  image,
                  height: 50,
                ),
              )
            ]),
            Stack(alignment: Alignment.center, children: <Widget>[
              Image.asset(
                'images/crown.png',
                height: 30,
              ),
              Text(
                number,
                style: const TextStyle(color: Colors.deepOrangeAccent),
              ),
            ]),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        )
      ]),
    );
  }

  Widget twoLessons(Widget lesson1, Widget lesson2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        lesson1,
        const SizedBox(
          width: 20,
        ),
        lesson2
      ],
    );
  }
}
