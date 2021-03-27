import 'package:flutter/material.dart';
import 'dart:math';

class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) => LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.center,
        colors: [Colors.black54, Colors.transparent],
      ).createShader(rect),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage('http://10.0.2.2/projects/letbike/imgs/app/' +
                  new Random().nextInt(8).toString() +
                  '.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)),
        ),
      ),
    );
  }
}
