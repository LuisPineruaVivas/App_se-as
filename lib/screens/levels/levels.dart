import 'dart:math';
import 'package:first_app/auth/firestore.dart';
import 'package:first_app/screens/lesson/lesson1_screen.dart';
import 'package:first_app/screens/lesson/lesson2_screen.dart';
import 'package:first_app/screens/lesson/lesson3_screen.dart';
import 'package:first_app/screens/lesson/lesson4_screen.dart';
import 'package:first_app/screens/lesson/lesson5_screen.dart';
import 'package:first_app/screens/lesson/lesson6_screen.dart';
import 'package:first_app/screens/lesson/lesson7_screen.dart';
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
  num points = 0;
  bool isLoading = true;
  var lessons = [];

  @override
  void initState() {
    super.initState();
    _fetchPoints();
  }

  Future<void> _fetchPoints() async {
    try {
      lessons = await FirestoreDatasource.lessons().first;
      num totalPoints =
          lessons.fold(0, (sum, doc) => sum + (doc['respuestas'] ?? 0));
      if (mounted) {
        setState(() {
          points = totalPoints;
          isLoading = false; // Stop loading
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          isLoading = false; // Stop loading even on error
        });
      }
    }
  }

  Future<List<dynamic>> _fetchLessons() async {
    return lessons; // Simply return the already fetched lessons
  }

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
                appBarItem('images/crown.png', points, Colors.grey),
              ],
            )),
        body: Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            FutureBuilder(
                future: _fetchLessons(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text(
                            'Error cargando las lecciones \n Compruebe su conexion a internet'));
                  } else {
                    return ListView(
                      children: <Widget>[
                        const SizedBox(height: 15),
                        twoLessons(
                          lesson(
                              'images/vocales.png',
                              snapshot.data!.isNotEmpty
                                  ? snapshot.data!.firstWhere(
                                      (doc) => doc['title'] == 'Leccion 1',
                                      orElse: () => {'respuestas': 0},
                                    )['respuestas']
                                  : 0,
                              'Lección 1',
                              Colors.green,
                              1),
                          lesson(
                              'images/abc.png',
                              snapshot.data!.isNotEmpty
                                  ? snapshot.data!.firstWhere(
                                      (doc) => doc['title'] == 'Leccion 2',
                                      orElse: () => {'respuestas': 0},
                                    )['respuestas']
                                  : 0,
                              'Lección 2',
                              Colors.red,
                              2),
                        ),
                        const SizedBox(height: 15),
                        lesson(
                            'images/colores.png',
                            snapshot.data!.isNotEmpty
                                ? snapshot.data!.firstWhere(
                                    (doc) => doc['title'] == 'Leccion 3',
                                    orElse: () =>
                                        {'respuestas': 0})['respuestas']
                                : 0,
                            'Lección 3',
                            Colors.orange,
                            3),
                        const SizedBox(height: 15),
                        twoLessons(
                          lesson(
                              'images/numeros.png',
                              snapshot.data!.isNotEmpty
                                  ? snapshot.data!.firstWhere(
                                      (doc) => doc['title'] == 'Leccion 4',
                                      orElse: () =>
                                          {'respuestas': 0})['respuestas']
                                  : 0,
                              'Lección 4',
                              Colors.teal,
                              4),
                          lesson(
                              'images/dias.png',
                              snapshot.data!.isNotEmpty
                                  ? snapshot.data!.firstWhere(
                                        (doc) => doc['title'] == 'Leccion 5',
                                        orElse: () => {
                                          'respuestas': 0
                                        }, // Default if not found
                                      )['respuestas'] ??
                                      0 // Ensure null safety
                                  : 0,
                              'Lección 5',
                              Colors.greenAccent,
                              5),
                        ),
                        const SizedBox(height: 15),
                        lesson(
                            'images/salud.png',
                            snapshot.data!.isNotEmpty
                                ? snapshot.data!.firstWhere(
                                      (doc) => doc['title'] == 'Leccion 6',
                                      orElse: () => {'respuestas': 0},
                                    )['respuestas'] ??
                                    0
                                : 0,
                            'Lección 6',
                            Colors.redAccent,
                            6),
                        const SizedBox(height: 15),
                        lesson(
                            'images/saludo.png',
                            snapshot.data!.isNotEmpty
                                ? snapshot.data!.firstWhere(
                                      (doc) => doc['title'] == 'Leccion 7',
                                      orElse: () => {'respuestas': 0},
                                    )['respuestas'] ??
                                    0
                                : 0,
                            'Lección 7',
                            Colors.lightBlueAccent,
                            7)
                      ],
                    );
                  }
                })
          ],
        ));
  }

  Widget appBarItem(String image, num num, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          image,
          height: 30,
        ),
        Text(
          num.toString(),
          style: TextStyle(color: color, fontSize: 16),
        ),
      ],
    );
  }

  Widget lesson(
      String image, int number, String title, Color color, int lesson) {
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
        if (lesson == 7) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Lesson7Screen()));
        }
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
                  value: number / 10,
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
                number.toString(),
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
