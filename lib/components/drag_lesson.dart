// ignore_for_file: deprecated_member_use

import 'package:first_app/variables.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

//ignore: must_be_immutable
class DragLesson extends StatefulWidget {
  final Widget checkButton;
  final String imagen;
  List words;
  List answer;

  DragLesson(this.imagen, this.words, this.answer,
      {required this.checkButton, Key? key})
      : super(key: key);

  @override
  DragLessonState createState() => DragLessonState();
}

class DragLessonState extends State<DragLesson> {
  void removeWord(String word) {
    setState(() {
      widget.words.remove(word);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          instruction('Selecciona las palabras correctas'),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 30),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(widget.imagen,
                            height: 250, width: 300, fit: BoxFit.fill),
                      )),
                  const SizedBox(height: 20),
                  DroppableArea(widget.answer, onWordDropped: removeWord),
                  const SizedBox(height: 20),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: widget.words
                        .map((word) =>
                            DraggableWord(word: word, onWordDropped: (_) {}))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          widget.checkButton
        ],
      ),
    );
  }
}

class DraggableWord extends StatelessWidget {
  final String word;
  final Function(DraggableDetails) onWordDropped;

  const DraggableWord(
      {super.key, required this.word, required this.onWordDropped});

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: word,
      feedback: Material(
        color: Colors.blue.withOpacity(0.5),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 27, 97, 129),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 2.5,
              color: const Color.fromARGB(255, 27, 97, 129),
            ),
          ),
          padding: const EdgeInsets.all(5),
          child: Text(
            word,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      childWhenDragging: Container(),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 27, 97, 129),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 2.5,
            color: const Color.fromARGB(255, 27, 97, 129),
          ),
        ),
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.all(2),
        child: Text(
          word,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

class DroppableArea extends StatefulWidget {
  final Function(String) onWordDropped;
  final List answers;

  const DroppableArea(this.answers, {super.key, required this.onWordDropped});

  @override
  DroppableAreaState createState() => DroppableAreaState();
}

class DroppableAreaState extends State<DroppableArea> {
  List<String> acceptedWords = [];

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      builder: (context, accepted, rejected) {
        return Container(
          width: 300,
          height: 100,
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.black, width: 5))),
          child: Wrap(
            children: acceptedWords
                .map((word) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: DraggableWord(
                        word: word,
                        onWordDropped: (details) {
                          setState(() {
                            acceptedWords.remove(word);
                          });
                        },
                      ),
                    ))
                .toList(),
          ),
        );
      },
      onWillAcceptWithDetails: (data) {
        // Add any condition if you want to check before accepting the data
        return true;
      },
      onAccept: (String? data) {
        if (data != null) {
          setState(() {
            Function eq = const ListEquality().equals;
            acceptedWords.add(data);
            if (eq(acceptedWords, widget.answers)) {
              respuestas++;
            }
          });
          widget.onWordDropped(data);
        }
      },
    );
  }
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
