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

class SignEvaluation extends StatefulWidget {
  final Widget checkButton;
  final String instructionText;
  final List<String> answers;
  final String imagen;
  final String correct;

  const SignEvaluation(
      this.instructionText, this.answers, this.imagen, this.correct,
      {required this.checkButton, super.key});

  @override
  SignEvaluationState createState() => SignEvaluationState();
}

class SignEvaluationState extends State<SignEvaluation> {
  File? image;
  late ImagePicker imagePicker;
  late ImageLabeler labeler;
  String results = "";

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
      });
    }
  }

  performImageLabeling() async {
    final modelPath = await getModelPath('assets/model.tflite');
    final options =
        LocalLabelerOptions(modelPath: modelPath, confidenceThreshold: 0.5);
    labeler = ImageLabeler(options: options);
    results = "";
    InputImage inputImage = InputImage.fromFile(image!);

    final List<ImageLabel> labels = await labeler.processImage(inputImage);

    for (ImageLabel label in labels) {
      final String text = label.label;
      final double confidence = label.confidence;
      results += "Seña $text  ${confidence.toStringAsFixed(2)}\n";

      setState(() {
        results;
      });
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
                        Text(results),
                      ],
                    )),
                const Padding(
                  padding: EdgeInsets.only(bottom: 15),
                ),
              ],
            ),
          ),
        ),
        widget.checkButton,
      ],
    );
  }

  listChoice(String title) {
    return show
        ? Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 15, right: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 3,
                color: title == widget.correct ? Colors.green : Colors.red,
              ),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 17),
            ),
          )
        : Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 15, right: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 3,
                color: const Color.fromARGB(255, 27, 97, 129),
              ),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 17),
            ),
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
