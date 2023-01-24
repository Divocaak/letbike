import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/widgets/error_widgets.dart';
import 'dart:math';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

// TODO wtf barva?
  @override
  Widget build(BuildContext context) => ShaderMask(
      shaderCallback: (rect) => const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.center,
          colors: [Colors.black54, Colors.transparent]).createShader(rect),
      blendMode: BlendMode.darken,
      child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage('${imgsFolder}app/${Random().nextInt(8)}.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.darken),
                  onError: (object, stackTrace) => ErrorWidgets.imageLoadingError(Icons.image)))));
}
