import 'package:first_app/components/sena2_widget.dart';
import 'package:first_app/components/sena_widget.dart';
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class VideoLesson extends StatefulWidget {
  final Widget checkButton;
  final List images;
  final List names;
  final String info;
  final String leccion;
  final String titulo;
  final String tema;
  final int option;

  const VideoLesson(this.images, this.names, this.info, this.leccion,
      this.titulo, this.tema, this.option,
      {required this.checkButton, Key? key})
      : super(key: key);

  @override
  State<VideoLesson> createState() => _VideoLessonState();
}

class _VideoLessonState extends State<VideoLesson>
    with TickerProviderStateMixin {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.asset(widget.leccion));
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);

    return Scaffold(
      body: Column(
        children: [
          instruction(widget.titulo),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: FlickVideoPlayer(flickManager: flickManager)),
            ),
          ),
          const SizedBox(height: 10),
          Text(widget.tema,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4B4B4B),
              )),
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
                tabs: const [Tab(text: 'Leccion'), Tab(text: 'Señas')]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: double.maxFinite,
              height: 250,
              child: TabBarView(controller: tabController, children: [
                Text(widget.info,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                ListView.builder(
                    itemCount: widget.images.length,
                    itemBuilder: (contex, index) {
                      if (widget.option == 1) {
                        return SenaWidget('Seña', '${widget.names[index]}',
                            'images/${widget.images[index]}');
                      } else {
                        return SenaWidget2('Seña', '${widget.names[index]}',
                            'images/${widget.images[index]}');
                      }
                    }),
              ]),
            ),
          ),
          const SizedBox(height: 20),
          widget.checkButton,
        ],
      ),
    );
  }

  instruction(String text) {
    return Align(
      alignment: Alignment.center,
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
