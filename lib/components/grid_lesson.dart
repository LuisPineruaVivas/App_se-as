import 'package:first_app/variables.dart';
import 'package:flutter/material.dart';

class GridLesson extends StatefulWidget {
  final Widget checkButton;
  final String sign;
  final String imagen1;
  final String imagen2;
  final String imagen3;
  final String imagen4;
  final String correct;

  const GridLesson(this.sign, this.imagen1, this.imagen2, this.imagen3,
      this.imagen4, this.correct,
      {required this.checkButton, Key? key})
      : super(key: key);

  @override
  GridLessonState createState() => GridLessonState();
}

class GridLessonState extends State<GridLesson> {
  bool show = false;
  bool isactive = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        instruction('Selecciona la seña correcta'),
        questionRow(widget.sign),
        GridView.count(
          primary: false,
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 15, right: 15),
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 5,
          childAspectRatio: 0.8,
          children: [
            GestureDetector(
              onTap: () {
                show = true;
                setState(() {});
                if (isactive) {
                  setState(() {
                    isactive = false;
                  });
                  if (widget.imagen1 == widget.correct) {
                    respuestas++;
                  }
                }
              },
              child: gridChoice(
                widget.imagen1,
              ),
            ),
            GestureDetector(
              onTap: () {
                show = true;
                setState(() {});
                if (isactive) {
                  setState(() {
                    isactive = false;
                  });
                  if (widget.imagen2 == widget.correct) {
                    respuestas++;
                  }
                }
              },
              child: gridChoice(
                widget.imagen2,
              ),
            ),
            GestureDetector(
              onTap: () {
                show = true;
                setState(() {});
                if (isactive) {
                  setState(() {
                    isactive = false;
                  });
                  if (widget.imagen3 == widget.correct) {
                    respuestas++;
                  }
                }
              },
              child: gridChoice(
                widget.imagen3,
              ),
            ),
            GestureDetector(
              onTap: () {
                show = true;
                setState(() {});
                if (isactive) {
                  setState(() {
                    isactive = false;
                  });
                  if (widget.imagen4 == widget.correct) {
                    respuestas++;
                  }
                }
              },
              child: gridChoice(
                widget.imagen4,
              ),
            ),
          ],
        ),
        widget.checkButton,
      ],
    );
  }

  gridChoice(String image) {
    return show
        ? Container(
            height: 250,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 27, 97, 129),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 3,
                color: image == widget.correct ? Colors.green : Colors.red,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    padding: const EdgeInsets.all(5),
                    child: Center(child: Image.asset(image, scale: 0.5))),
              ],
            ),
          )
        : Container(
            height: 250,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 27, 97, 129),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 3,
                color: const Color.fromARGB(255, 27, 97, 129),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    padding: const EdgeInsets.all(5),
                    child: Center(child: Image.asset(image, scale: 0.5))),
              ],
            ),
          );
  }

  questionRow(String question) {
    return Container(
      margin: const EdgeInsets.only(left: 15, bottom: 1),
      child: Row(
        children: [
          speakButton(),
          const Padding(padding: EdgeInsets.only(right: 15)),
          Text(
            question,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4B4B4B)),
          )
        ],
      ),
    );
  }

  speakButton() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFF1CB0F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.volume_up,
        color: Colors.white,
        size: 35,
      ),
    );
  }

  instruction(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 15),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4B4B4B),
          ),
        ),
      ),
    );
  }
}
