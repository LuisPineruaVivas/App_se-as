import 'package:first_app/auth/firestore.dart';
import 'package:flutter/material.dart';
import 'package:first_app/components/lesson_widget.dart';

class LessonItem extends StatelessWidget {
  const LessonItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: FirestoreDatasource.lessons(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final List<Map<String, dynamic>> data = snapshot.data ?? [];
            return Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final lesson = data[index];
                    return LessonWidget(
                      lesson['title'],
                      lesson['imagen'],
                      lesson['subtitle'],
                      lesson['respuestas'],
                    );
                  }),
            );
          }),
    );
  }
}
