import 'package:first_app/auth/firestore.dart';
import 'package:first_app/components/evaluation_widget.dart';
import 'package:flutter/material.dart';

class EvaluationItem extends StatelessWidget {
  const EvaluationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: FirestoreDatasource.evaluations(),
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
                  return EvaluationWidget(
                    tarea['title'],
                    tarea['imagen'],
                    tarea['subtitle'],
                    tarea['respuestas'],
                  );
                });
          }),
    );
  }
}
