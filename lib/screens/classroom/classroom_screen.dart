import 'package:first_app/auth/firestore.dart';
import 'package:first_app/screens/classroom/classroom_list.dart';
import 'package:first_app/screens/classroom/classroom_page.dart';
import 'package:flutter/material.dart';

class ClassroomScreen extends StatefulWidget {
  const ClassroomScreen({super.key});

  @override
  State<ClassroomScreen> createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends State<ClassroomScreen> {
  Stream<Map<String, dynamic>?> userData = FirestoreDatasource.userData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<Map<String, dynamic>?>(
        stream: userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data available'));
          } else {
            Map<String, dynamic>? data = snapshot.data;
            bool isProfessor = data?['isProfessor'] ?? false;
            if (isProfessor) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Card(
                        elevation: 50,
                        shadowColor: Colors.black,
                        color: const Color.fromARGB(255, 0, 105, 155),
                        child: SizedBox(
                          width: 350,
                          height: 500,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 80,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'images/conference_card.png'),
                                    radius: 80,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Bienvenido Profesor',
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white),
                                ),
                                Text(data?['nombre'] ?? '',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white)),
                                ListTile(
                                  title: Text(
                                      'Estado: ${data?['acceptCalls'] ? 'Disponible' : 'No disponible'}',
                                      style: TextStyle(color: Colors.white)),
                                  trailing: StreamBuilder<bool>(
                                      stream: data?['acceptCalls'] != null
                                          ? Stream.value(data?['acceptCalls'])
                                          : Stream.value(false),
                                      builder: (context, snapshot) {
                                        final acceptCalls =
                                            snapshot.data ?? true;
                                        return Switch(
                                          activeColor: Colors.white,
                                          inactiveTrackColor: Colors.white,
                                          value: acceptCalls,
                                          onChanged: (value) {
                                            FirestoreDatasource
                                                .updateAcceptCalls(
                                                    value ? true : false);
                                          },
                                        );
                                      }),
                                ),
                                SizedBox(height: 10),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black),
                                  onPressed: () {
                                    data?['acceptCalls']
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ClassroomPage(
                                                      conferenceID: data?['id'],
                                                      username: data?['nombre'],
                                                      userID: data?['id'],
                                                    )))
                                        : showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              content: const Text(
                                                'Recuerda cambiar tu estado a disponible para poder crear una sala de clase asi otros usuarios pueden unirse a tu sala',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'OK'),
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ),
                                          );
                                  },
                                  icon: Image.asset(
                                    'images/conference.png',
                                    width: 40,
                                  ),
                                  label: Text('Crear Sala de Clase',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                )
                              ],
                            ),
                          ),
                        )),
                  ),
                ],
              );
            } else {
              return ClassroomList();
            }
          }
        },
      ),
    );
  }
}
