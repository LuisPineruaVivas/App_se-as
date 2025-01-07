import 'package:flutter/material.dart';

class ProfesorWidget extends StatefulWidget {
  final String nombre;
  final String status;
  final String idcall;
  final String iduser;
  final VoidCallback? onPressed;

  const ProfesorWidget(this.nombre, this.status,
      {super.key, this.onPressed, required this.idcall, required this.iduser});

  @override
  State<ProfesorWidget> createState() => _ProfesorWidgetState();
}

class _ProfesorWidgetState extends State<ProfesorWidget> {
  @override
  Widget build(BuildContext context) {
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
                              Text(
                                widget.nombre,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Text('Estado: ${widget.status}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              const Spacer(),
                              actionButton(context),
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
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(image: AssetImage('images/person2.png'))),
    );
  }

  Widget actionButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (widget.onPressed != null && widget.status == 'Disponible') {
          widget.onPressed!();
        } else {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Upss'),
              icon: Image.asset('images/soon.png'),
              content: const Text(
                'Este profesor no está disponible en este momento',
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
                  Image.asset('images/conference.png'),
                  const SizedBox(width: 10),
                  const Text(
                    'Ingresar a la sala',
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
