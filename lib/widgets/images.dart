import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/widgets/errorWidgets.dart';
import 'dart:math';

import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:permission_handler/permission_handler.dart';

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

class ServerImage extends StatelessWidget {
  const ServerImage({Key? key, required String path})
      : _path = path,
        super(key: key);

  final String _path;

  @override
  Widget build(BuildContext context) => Center(
      child: FadeInImage.assetNetwork(
          fit: BoxFit.fitWidth,
          placeholder: 'assets/load.gif',
          image: _path,
          imageErrorBuilder: (context, exception, stackTrace) =>
              ErrorWidgets.imageLoadingError(Icons.image)));
}

class ImagePickerController extends State {
  @override
  build(context) => Container();

  Future<int> checkPerm() async {
    var status = await Permission.camera.status;
    if (status != PermissionStatus.granted) {
      await Permission.camera.request();
      return Permission.camera.value;
    } else {
      return 1;
    }
  }

  loadAssets(State<dynamic> state, List<Asset>? images, int maxImages,
      bool mounted, context, Function(List<Asset>) setImages) async {
    state.setState(() => images = []);
    List<Asset>? resultList;
    String? error;

    if (await checkPerm() == 1) {
      try {
        resultList = await MultiImagePicker.pickImages(
            maxImages: maxImages, enableCamera: true, selectedAssets: images!);
      } on Exception catch (e) {
        error = e.toString();
      }

      if (!mounted) return;

      if (resultList != null) {
        state.setState(() => images = resultList);
        setImages(resultList);
      }
      if (error != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Chyba: " + error)));
      }
    }
  }

  Widget buildGridView(List<Asset>? images, int crossAxisCount, int size) {
    if (images != null) {
      return GridView.count(
          crossAxisCount: crossAxisCount,
          children: List.generate(
              images.length,
              (index) =>
                  AssetThumb(asset: images[index], width: size, height: size)));
    } else {
      return Container();
    }
  }
}
