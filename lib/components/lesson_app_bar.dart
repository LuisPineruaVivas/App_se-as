import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LessonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double percent;
  const LessonAppBar({required this.percent, super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 60,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      title: progressBar(context, percent),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: IconButton(
          icon: const Icon(
            Icons.close,
            color: Color(0xFFAFAFAF),
            size: 35,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  progressBar(BuildContext context, double percent) {
    return LinearPercentIndicator(
      width: MediaQuery.of(context).size.width - 100,
      animation: true,
      lineHeight: 15.0,
      animationDuration: 100,
      percent: percent / 100,
      barRadius: const Radius.circular(10),
      backgroundColor: const Color(0xFFE5E5E5),
      progressColor: const Color.fromARGB(255, 0, 105, 155),
    );
  }
}
