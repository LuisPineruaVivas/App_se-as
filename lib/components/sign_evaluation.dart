import 'dart:io';
import 'package:first_app/variables.dart';
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

class SignEvaluation extends StatefulWidget {
  final Widget checkButton;
  final String instructionText;
  final List<String> answers;
  final String correct;
  String image;
  String results;

  SignEvaluation(this.instructionText, this.answers, this.correct, this.image,
      this.results,
      {required this.checkButton, super.key});

  @override
  SignEvaluationState createState() => SignEvaluationState();
}

class SignEvaluationState extends State<SignEvaluation> {
  File? image;
  late ImagePicker imagePicker;
  late ImageLabeler labeler;
  bool realizada = false;

  bool show = false;
  bool isactive = true;

  @override
  initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  chooseImage() async {
    XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (selectedImage != null) {
      image = File(selectedImage.path);
      performImageLabeling();
      setState(() {
        image;
        widget.image = 'Yes';
      });
    }
  }

  performImageLabeling() async {
    final modelPath = await getModelPath('assets/lesson1/model.tflite');
    final options =
        LocalLabelerOptions(modelPath: modelPath, confidenceThreshold: 0.5);
    labeler = ImageLabeler(options: options);
    widget.results = "";
    InputImage inputImage = InputImage.fromFile(image!);

    final List<ImageLabel> labels = await labeler.processImage(inputImage);

    for (ImageLabel label in labels) {
      print(widget.correct);
      final String text = label.label;
      print(text);
      final int index = label.index;
      print(index);
      final double confidence = label.confidence;

      if (widget.correct == 'A' && index == 0 && confidence >= 0.5) {
        setState(() {
          respuestas++;
          widget.results = "Seña correcta";
          realizada = true;
        }); // Llama a la función de respuesta correcta
      } else if (widget.correct == 'E' && index == 1 && confidence >= 0.5) {
        setState(() {
          respuestas++;
          widget.results = "Seña correcta";
          realizada = true;
        }); // Llama a la función de respuesta correcta
      } else if (widget.correct == 'I' && index == 2 && confidence >= 0.5) {
        setState(() {
          respuestas++;
          widget.results = "Seña correcta";
          realizada = true;
        }); // Llama a la función de respuesta correcta
      } else if (widget.correct == 'O' && index == 3 && confidence >= 0.5) {
        setState(() {
          respuestas++;
          widget.results = "Seña correcta";
          realizada = true;
        }); // Llama a la función de respuesta correcta
      } else if (widget.correct == 'U' && index == 4 && confidence >= 0.5) {
        setState(() {
          respuestas++;
          widget.results = "Seña correcta";
          realizada = true;
        }); // Llama a la función de respuesta correcta
      } else {
        setState(() {
          widget.results = "Seña incorrecta";
          realizada = true;
        });
      }
    }
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
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: Column(
                      children: [
                        widget.image == ''
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
                          onTap: () {
                            chooseImage();
                          },
                          child: Container(
                              height: 35,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 0, 105, 155),
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Center(
                                child: Text(
                                  'Grabar Seña',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                        Text(widget.results,
                            style: widget.results == "Seña correcta"
                                ? const TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)
                                : const TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                      ],
                    )),
                const Padding(
                  padding: EdgeInsets.only(bottom: 15),
                ),
              ],
            ),
          ),
        ),
        realizada ? widget.checkButton : const SizedBox(height: 10),
      ],
    );
  }

  questionRow(String question) {
    return Container(
      margin: const EdgeInsets.only(left: 15, bottom: 5),
      child: Row(
        children: [
          speakButton(),
          const Padding(padding: EdgeInsets.only(right: 15)),
          Text(
            question,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4B4B4B)),
          )
        ],
      ),
    );
  }

  speakButton() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFF1CB0F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.volume_up,
        color: Colors.white,
        size: 35,
      ),
    );
  }

  instruction(String text) {
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
