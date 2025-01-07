import 'package:first_app/auth/firestore.dart';
import 'package:first_app/screens/classroom/classroom_page.dart';
import 'package:first_app/screens/classroom/profesor_widget.dart';
import 'package:flutter/material.dart';

class ClassroomList extends StatefulWidget {
  const ClassroomList({super.key});

  @override
  State<ClassroomList> createState() => _ClassroomListState();
}

class _ClassroomListState extends State<ClassroomList> {
  @override
  Widget build(BuildContext context) {
    var nombre = '';
    var userId = '';
    FirestoreDatasource.userDataJson().then((userdata) {
      nombre = userdata?['nombre'];
      userId = userdata?['id'];
    });
    //access to the user data
    return StreamBuilder<List<Map<String, dynamic>>>(
        stream: FirestoreDatasource.users(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final List<Map<String, dynamic>> data = snapshot.data ?? [];
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final profesor = data[index];
                return profesor['isProfessor']
                    ? ProfesorWidget(
                        profesor['nombre'],
                        profesor['acceptCalls']
                            ? 'Disponible'
                            : 'No disponible',
                        idcall: profesor['id'],
                        iduser: profesor['id'],
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClassroomPage(
                                      conferenceID: profesor['id'],
                                      username: nombre,
                                      userID: userId)));
                        },
                      )
                    : Container();
              });
        });
  }
}
