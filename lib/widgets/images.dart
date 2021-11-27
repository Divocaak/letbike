import 'package:flutter/material.dart';
import 'package:letbike/db/remoteSettings.dart';
import 'package:letbike/general/pallete.dart';
import 'package:letbike/widgets/errorWidgets.dart';
import 'dart:math';
import 'package:palette_generator/palette_generator.dart';

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
  Widget build(String path) {
    Future<PaletteGenerator> palette = _updatePaletteGenerator(path);

    return FutureBuilder<PaletteGenerator>(
        future: palette,
        builder: (context, snapshot) {
          return Stack(children: [
            Container(
                color: snapshot.data == null
                    ? kWhite.withOpacity(.05)
                    : snapshot.data.dominantColor.color),
            Center(
                child: FadeInImage.assetNetwork(
                    fit: BoxFit.fitWidth,
                    placeholder: 'assets/load.gif',
                    image: path,
                    imageErrorBuilder: (context, exception, stackTrace) =>
                        ErrorWidgets.imageLoadingError(Icons.image)))
          ]);
        });
  }

  Future<PaletteGenerator> _updatePaletteGenerator(String path) async {
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(NetworkImage(path));
    return paletteGenerator;
  }
}
