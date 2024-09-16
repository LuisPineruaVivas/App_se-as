import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.buttonText, required this.onTap});
  final String buttonText;
  final Widget onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (e) => onTap,
          ),
        );
      },
      child: Container(
          height: 50,
          width: 250,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: Text(
              buttonText,
              style:
                  const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}
