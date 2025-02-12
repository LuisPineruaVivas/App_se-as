import 'dart:io';
import 'package:first_app/auth/firestore.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'savePDF.dart';

class PdfApi {
  static Future<File> generateSimpleTextPdf() async {
    try {
      final lessonsStream = FirestoreDatasource.lessons();
      final evaluationsStream = FirestoreDatasource.evaluations();
      final pdf = Document();

      final lessons = await lessonsStream.first;
      final evaluations = await evaluationsStream.first;

      final List<List<String>> tableData = [
        ['Lecciones', 'Progreso', 'Evaluaciones', 'Progreso'],
      ];

      final int maxLength = lessons.length > evaluations.length
          ? lessons.length
          : evaluations.length;

      for (int i = 0; i < maxLength; i++) {
        tableData.add([
          i < lessons.length ? lessons[i]['title'] ?? '' : '',
          i < lessons.length ? lessons[i]['respuestas'].toString() : '',
          i < evaluations.length ? evaluations[i]['title'] ?? '' : '',
          i < evaluations.length ? evaluations[i]['respuestas'].toString() : '',
        ]);
      }

      pdf.addPage(MultiPage(
          build: (_) => [
                customHeader(),
                TableHelper.fromTextArray(
                  data: tableData,
                  headers: tableData.first,
                ),
              ]));

      return SaveAndOpenDocument.savePdf(name: 'Reporte.pdf', pdf: pdf);
    } catch (e) {
      return Future.error(e);
    }
  }

  static Widget customHeader() => Container(
      padding: const EdgeInsets.only(bottom: 3 * PdfPageFormat.dp),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 2, color: PdfColors.blue)),
      ),
      child: Row(children: [
        PdfLogo(),
        SizedBox(
          width: 0.5 * PdfPageFormat.cm,
        ),
        Text('Reporte de aprendizaje',
            style: TextStyle(
                fontSize: 40,
                color: PdfColors.blue,
                fontWeight: FontWeight.bold)),
      ]));
}
