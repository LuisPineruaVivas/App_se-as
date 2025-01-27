import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<String> getModelPath(String asset) async {
  final path = '${(await getApplicationSupportDirectory()).path}/$asset';
  await Directory(dirname(path)).create(recursive: true);
  final file = File(path);
  if (!await file.exists()) {
    final byteData = await rootBundle.load(asset);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }
  return file.path;
}

class SignEvaluation2 extends StatefulWidget {
  final String instructionText;
  final List<String> answers;
  final String correct;
  final Function onSenaCorrecta;
  final Function onSenaIncorrecta;

  const SignEvaluation2(
    this.instructionText,
    this.answers,
    this.correct, {
    required this.onSenaCorrecta,
    required this.onSenaIncorrecta,
    super.key,
  });

  @override
  SignEvaluation2State createState() => SignEvaluation2State();
}

class SignEvaluation2State extends State<SignEvaluation2> {
  File? image;
  late ImagePicker imagePicker;
  late ImageLabeler labeler;
  String results = "";

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  Future<void> chooseImage() async {
    XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (selectedImage != null) {
      image = File(selectedImage.path);
      await performImageLabeling();
      setState(() {
        image;
      });
    }
  }

  Future<void> performImageLabeling() async {
    final modelPath = await getModelPath('assets/model.tflite');
    final options =
        LocalLabelerOptions(modelPath: modelPath, confidenceThreshold: 0.5);
    labeler = ImageLabeler(options: options);
    results = "";
    InputImage inputImage = InputImage.fromFile(image!);

    final List<ImageLabel> labels = await labeler.processImage(inputImage);

    bool isCorrect = false; // Para verificar si la respuesta es correcta

    for (ImageLabel label in labels) {
      final String text = label.label;
      final double confidence = label.confidence;

      if (text == widget.correct && confidence >= 0.5) {
        isCorrect = true;
        widget.onSenaCorrecta(); // Llama a la función de respuesta correcta
        break;
      }
    }

    if (!isCorrect) {
      widget.onSenaIncorrecta(); // Llama a la función de respuesta incorrecta
    }

    // Actualiza el resultado en pantalla
    setState(() {
      results = labels
          .map((label) =>
              "Seña ${label.label} - Confianza: ${label.confidence.toStringAsFixed(2)}")
          .join("\n");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        instruction(widget.instructionText),
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Column(
                    children: [
                      image == null
                          ? const Icon(
                              Icons.image_outlined,
                              size: 300,
                            )
                          : Image.file(
                              image!,
                              height: 400,
                            ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: chooseImage,
                        child: Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 0, 105, 155),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              'Grabar Seña',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        results,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 15),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget instruction(String text) {
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
