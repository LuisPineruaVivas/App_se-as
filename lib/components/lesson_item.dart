import 'package:first_app/auth/firestore.dart';
import 'package:flutter/material.dart';
import 'package:first_app/components/lesson_widget.dart';

class LessonItem extends StatelessWidget {
  const LessonItem({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
        stream: FirestoreDatasource.lessons(),
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
                final tarea = data[index];
                print(tarea);
                return LessonWidget(
                  tarea['title'],
                  tarea['imagen'],
                  tarea['subtitle'],
                  tarea['respuestas'],
                );
              });
        });
  }
}
