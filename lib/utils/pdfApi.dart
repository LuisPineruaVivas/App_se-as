import 'dart:io';
import 'package:first_app/auth/firestore.dart';
import 'package:pdf/pdf.dart';
import 'savePDF.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pw;

const sep = 120.0;

class PdfApi {
  static Future<File> generatePDF() async {
    try {
      final lessonsStream = FirestoreDatasource.lessons();
      final evaluationsStream = FirestoreDatasource.evaluations();
      var nombre = '';
      var correo = '';
      FirestoreDatasource.userDataJson().then((userdata) {
        nombre = userdata?['nombre'];
        correo = userdata?['correo'];
      });
      final pdf = pw.Document();

      final lessons = await lessonsStream.first;
      final evaluations = await evaluationsStream.first;

      final int maxLength = lessons.length > evaluations.length
          ? lessons.length
          : evaluations.length;

      List<pw.MemoryImage?> lessonImages = await Future.wait(
        lessons.map((lesson) async {
          if (lesson['imagen'] != null && lesson['imagen'].isNotEmpty) {
            final bytes =
                (await rootBundle.load(lesson['imagen'])).buffer.asUint8List();
            return pw.MemoryImage(bytes);
          }
          return null;
        }),
      );

      List<pw.MemoryImage?> evaluationImages = await Future.wait(
        evaluations.map((evaluation) async {
          if (evaluation['imagen'] != null && evaluation['imagen'].isNotEmpty) {
            final bytes = (await rootBundle.load(evaluation['imagen']))
                .buffer
                .asUint8List();
            return pw.MemoryImage(bytes);
          }
          return null;
        }),
      );

      final bgShape = await rootBundle.loadString('assets/document.svg');
      final profileImage = pw.MemoryImage(
        (await rootBundle.load('images/person2.png')).buffer.asUint8List(),
      );

      pdf.addPage(pw.MultiPage(
          pageTheme: pw.PageTheme(
              buildBackground: (context) => pw.FullPage(
                    ignoreMargins: true,
                    child: pw.SvgImage(svg: bgShape, fit: pw.BoxFit.fill),
                  )),
          build: (_) => [
                pw.Padding(padding: const pw.EdgeInsets.only(top: 50, left: 0)),
                customHeader(),
                pw.Padding(padding: const pw.EdgeInsets.only(top: 30)),
                pw.Partitions(children: [
                  pw.Partition(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: <pw.Widget>[
                        pw.Container(
                            padding:
                                const pw.EdgeInsets.only(left: 30, bottom: 20),
                            child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: <pw.Widget>[
                                  pw.Text(nombre,
                                      textScaleFactor: 2,
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Padding(
                                      padding:
                                          const pw.EdgeInsets.only(top: 10)),
                                  pw.Row(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                      children: <pw.Widget>[
                                        pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: <pw.Widget>[
                                              pw.Text(
                                                'Correo: $correo',
                                                textScaleFactor: 1.5,
                                              ),
                                              pw.Text(
                                                'Lecciones completadas: ${lessons.length}',
                                                textScaleFactor: 1.5,
                                              ),
                                              pw.Text(
                                                'Evaluaciones completadas: ${evaluations.length}',
                                                textScaleFactor: 1.5,
                                              ),
                                            ])
                                      ])
                                ]))
                      ],
                    ),
                  ),
                  pw.Partition(
                      width: sep,
                      child: pw.Column(children: [
                        pw.Container(
                            child: pw.Column(
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: <pw.Widget>[
                              pw.ClipOval(
                                  child: pw.Container(
                                      width: 100,
                                      height: 100,
                                      color: PdfColors.blue,
                                      child: pw.Image(profileImage)))
                            ]))
                      ]))
                ]),
                pw.Padding(padding: const pw.EdgeInsets.only(top: 30)),
                pw.Table(
                  columnWidths: {
                    0: pw.FixedColumnWidth(30), // Image column width
                    1: pw.FlexColumnWidth(), // Lesson Title
                    2: pw.FixedColumnWidth(60), // Progress
                    3: pw.FixedColumnWidth(30), // Image column width
                    4: pw.FlexColumnWidth(), // Evaluation Title
                    5: pw.FixedColumnWidth(60), // Progress
                  },
                  children: [
                    // Table Headers
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColors.grey300),
                      children: [
                        pw.Container(), // Empty space for images
                        pw.Text('Lecciones',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text('Puntaje',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Container(),
                        pw.Text('Evaluaciones',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text('Puntaje',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ],
                    ),
                    // Table Rows
                    for (int i = 0; i < maxLength; i++)
                      pw.TableRow(
                        children: [
                          i < lessons.length && lessonImages[i] != null
                              ? pw.Container(
                                  height: 30,
                                  width: 30,
                                  child: pw.Image(lessonImages[i]!),
                                )
                              : pw.Container(height: 30, width: 30),
                          pw.Text(i < lessons.length
                              ? lessons[i]['subtitle'] ?? ''
                              : ''),
                          pw.Text(i < lessons.length
                              ? '${lessons[i]['respuestas'].toString()}/10'
                              : ''),
                          i < evaluations.length && evaluationImages[i] != null
                              ? pw.Container(
                                  height: 30,
                                  width: 30,
                                  child: pw.Image(evaluationImages[i]!),
                                )
                              : pw.Container(height: 30, width: 30),
                          pw.Text(i < evaluations.length
                              ? evaluations[i]['subtitle'] ?? ''
                              : ''),
                          pw.Text(i < evaluations.length
                              ? '${evaluations[i]['respuestas'].toString()}/10'
                              : ''),
                        ],
                      ),
                  ],
                ),
              ]));

      return SaveAndOpenDocument.savePdf(name: 'Reporte.pdf', pdf: pdf);
    } catch (e) {
      return Future.error(e);
    }
  }

  static pw.Widget customHeader() => pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 3 * PdfPageFormat.dp),
      decoration: const pw.BoxDecoration(
        border:
            pw.Border(bottom: pw.BorderSide(width: 2, color: PdfColors.blue)),
      ),
      child: pw.Row(children: [
        pw.PdfLogo(),
        pw.SizedBox(
          width: 0.2 * PdfPageFormat.cm,
        ),
        pw.Text('RESUMEN DE AVANCE',
            style: pw.TextStyle(
                fontSize: 30,
                color: PdfColors.black,
                fontWeight: pw.FontWeight.bold)),
      ]));
}
