import 'package:first_app/variables.dart';
import 'package:flutter/material.dart';

class ListLesson extends StatefulWidget {
  final Widget checkButton;
  final String instructionText;
  final List<String> answers;
  final String imagen;
  final String correct;

  const ListLesson(
      this.instructionText, this.answers, this.imagen, this.correct,
      {required this.checkButton, Key? key})
      : super(key: key);

  @override
  ListLessonState createState() => ListLessonState();
}

class ListLessonState extends State<ListLesson> {
  bool show = false;
  bool isactive = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        instruction(widget.instructionText),
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(widget.imagen,
                          height: 250, width: 300, fit: BoxFit.fill),
                    )),
                const Padding(
                  padding: EdgeInsets.only(bottom: 15),
                ),
                GestureDetector(
                  onTap: () {
                    show = true;
                    setState(() {});
                    if (isactive) {
                      setState(() {
                        isactive = false;
                      });
                      if (widget.answers[0] == widget.correct) {
                        respuestas++;
                      }
                    }
                  },
                  child: listChoice(
                    widget.answers[0],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 15),
                ),
                GestureDetector(
                  onTap: () {
                    show = true;
                    setState(() {});
                    if (isactive) {
                      setState(() {
                        isactive = false;
                      });
                      if (widget.answers[1] == widget.correct) {
                        respuestas++;
                      }
                    }
                  },
                  child: listChoice(
                    widget.answers[1],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 15),
                ),
                GestureDetector(
                  onTap: () {
                    show = true;
                    setState(() {});
                    if (isactive) {
                      setState(() {
                        isactive = false;
                      });
                      if (widget.answers[2] == widget.correct) {
                        respuestas++;
                      }
                    }
                  },
                  child: listChoice(
                    widget.answers[2],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 15),
                ),
                GestureDetector(
                  onTap: () {
                    show = true;
                    setState(() {});
                    if (isactive) {
                      setState(() {
                        isactive = false;
                      });
                      if (widget.answers[3] == widget.correct) {
                        respuestas++;
                      }
                    }
                  },
                  child: listChoice(
                    widget.answers[3],
                  ),
                ),
              ],
            ),
          ),
        ),
        widget.checkButton,
      ],
    );
  }

  listChoice(String title) {
    return show
        ? Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 15, right: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 3,
                color: title == widget.correct ? Colors.green : Colors.red,
              ),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 17),
            ),
          )
        : Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 15, right: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 3,
                color: const Color.fromARGB(255, 27, 97, 129),
              ),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 17),
            ),
          );
  }

  questionRow(String question) {
    return Container(
      margin: const EdgeInsets.only(left: 15, bottom: 5),
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
