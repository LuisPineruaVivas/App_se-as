import 'package:flutter/material.dart';

class EvaluationWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final String image;
  final bool isDone;
  final VoidCallback? onPressed;

  const EvaluationWidget(this.title, this.subtitle, this.image, this.isDone,
      {super.key, this.onPressed});

  @override
  State<EvaluationWidget> createState() => _EvaluationWidgetState();
}

class _EvaluationWidgetState extends State<EvaluationWidget> {
  @override
  Widget build(BuildContext context) {
    bool isDone = widget.isDone;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 2),
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  imagen(),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.title,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Checkbox(
                                      value: isDone,
                                      activeColor: const Color.fromARGB(
                                          255, 0, 105, 155),
                                      shape: const CircleBorder(),
                                      onChanged: (value) {
                                        setState(() {
                                          isDone = !isDone;
                                        });
                                      })
                                ],
                              ),
                              Text(widget.subtitle,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              const Spacer(),
                              actionButton(context)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget imagen() {
    return Container(
      height: 130,
      width: 100,
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(image: AssetImage(widget.image))),
    );
  }

  Widget actionButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (widget.onPressed != null) {
          widget.onPressed!();
        } else {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Upss'),
              icon: Image.asset('images/soon.png'),
              content: const Text(
                'Las evaluaciones estaran disponibles proximamente',
                style: TextStyle(fontSize: 20),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              width: 200,
              height: 30,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 105, 155),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(children: [
                  Image.asset('images/test.png'),
                  const SizedBox(width: 10),
                  const Text(
                    'Realizar Evaluacion',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
