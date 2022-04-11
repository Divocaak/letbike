import 'package:flutter/material.dart';
import 'package:letbike/settings.dart';
import 'package:letbike/widgets/error_widgets.dart';
import 'dart:math';

class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ShaderMask(
      shaderCallback: (rect) => LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.center,
          colors: [Colors.black54, Colors.transparent]).createShader(rect),
      blendMode: BlendMode.darken,
      child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imgsFolder +
                      '/app/' +
                      new Random().nextInt(8).toString() +
                      '.jpg'),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.black54, BlendMode.darken),
                  onError: (object, stackTrace) =>
                      ErrorWidgets.imageLoadingError(Icons.image)))));
}
