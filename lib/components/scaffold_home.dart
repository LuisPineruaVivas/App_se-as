import 'package:flutter/material.dart';

class ScaffoldHome extends StatelessWidget {
  const ScaffoldHome({super.key, required this.child, required this.image});
  final Widget child;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(size: 40, color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity),
          SafeArea(
            child: child,
          )
        ],
      ),
    );
  }
}
