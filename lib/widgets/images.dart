import 'package:flutter/material.dart';
import 'package:letbike/db/remoteSettings.dart';
import 'package:letbike/general/pallete.dart';
import 'package:letbike/widgets/errorWidgets.dart';
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
              image: NetworkImage(imgsFolder +
                  '/app/' +
                  new Random().nextInt(8).toString() +
                  '.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              onError: (object, stackTrace) =>
                  ErrorWidgets.imageLoadingError(Icons.image)),
        ),
      ),
    );
  }
}

class ServerImage {
  static Widget build(String path) {
    return Container(
        color: kWhite.withOpacity(.05),
        child: Center(
            child: FadeInImage.assetNetwork(
                fit: BoxFit.scaleDown,
                placeholder: 'assets/load.gif',
                image: path,
                imageErrorBuilder: (context, exception, stackTrace) =>
                    ErrorWidgets.imageLoadingError(Icons.image))));
  }
}
