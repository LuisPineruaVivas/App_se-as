// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:first_app/screens/evaluations/evaluations.dart';
import 'package:first_app/screens/levels/levels.dart';
import 'package:first_app/screens/home/perfin.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        indicatorColor: Colors.blueAccent,
        selectedIndex: _currentIndex,
        destinations: <Widget>[
          navBarItem('images/level.png', 'images/level2.png', 'Lecciones'),
          navBarItem('images/book.png', 'images/book2.png', 'Evaluaciones'),
          navBarItem('images/person.png', 'images/person2.png', 'Perfil'),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          const LevelsScreen(),
          const EvaluationScreen(),
          const PerfilScreen()
        ],
      ),
    );
  }

  Widget navBarItem(String image, String activeimage, String label) {
    return NavigationDestination(
      icon: Image.asset(
        image,
        height: 30,
      ),
      label: label,
      selectedIcon: Image.asset(activeimage),
    );
  }
}
