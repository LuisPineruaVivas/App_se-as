import 'dart:io';

import 'package:first_app/components/evaluation_item.dart';
import 'package:first_app/components/lesson_item.dart';
import 'package:first_app/screens/home/controller/perfil_controller.dart';
import 'package:first_app/utils/pdfApi.dart';
import 'package:first_app/utils/savePDF.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../log/forgot_password.dart';

class PerfilScreen extends StatefulWidget {
  static String routeName = "/perfin";

  const PerfilScreen({super.key});
  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen>
    with TickerProviderStateMixin {
  final PerfilController _con = PerfilController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timestamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.help,
                      size: 40, color: Color.fromARGB(255, 0, 105, 155)),
                  onPressed: () async {
                    final byteData = await rootBundle.load('assets/MANUAL.pdf');
                    final tempDir = await getTemporaryDirectory();
                    final tempFile = File('${tempDir.path}/MANUAL.pdf');
                    await tempFile.writeAsBytes(byteData.buffer.asUint8List());
                    SaveAndOpenDocument.openPdf(tempFile);
                  },
                ),
                Text(
                  'Ayuda',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                )
              ],
            )),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 300,
                margin: const EdgeInsets.fromLTRB(28, 0, 28, 5),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.account_circle_outlined,
                        size: 70,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      _con.student?.nombre ?? 'Nombre',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      _con.student?.correo ?? 'Correo',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChangePasswordScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.lock_open, color: Colors.white),
                      label: const Text('Cambiar Contraseña'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 91, 175, 243),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        _con.signOut();
                      },
                      icon: const Icon(Icons.exit_to_app, color: Colors.white),
                      label: const Text('Cerrar Sesión'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 124, 115),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TabBar(
                    labelStyle: const TextStyle(fontSize: 18.0),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    controller: tabController,
                    indicator: const BoxDecoration(
                        color: Color.fromARGB(255, 0, 105, 155),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    tabs: const [
                      Tab(text: 'Lecciones'),
                      Tab(text: 'Evaluaciones')
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: double.maxFinite,
                  height: 300,
                  child: TabBarView(controller: tabController, children: [
                    const LessonItem(),
                    const EvaluationItem(),
                  ]),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Visibility(
          visible: true,
          child: FloatingActionButton(
            heroTag: 'btn',
            backgroundColor: const Color.fromARGB(255, 91, 175, 243),
            onPressed: () async {
              final pdfFile = await PdfApi.generatePDF();
              SaveAndOpenDocument.openPdf(pdfFile);
            },
            child: const Icon(Icons.edit_document),
          ),
        ));
  }

  void refresh() {
    setState(() {});
  }
}
