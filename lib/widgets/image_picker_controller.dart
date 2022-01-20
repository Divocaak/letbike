import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:permission_handler/permission_handler.dart';

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

  Widget buildGridView(List<Asset>? images, int crossAxisCount, int size) =>
      (images != null
          ? GridView.count(
              crossAxisCount: crossAxisCount,
              children: List.generate(
                  images.length,
                  (index) => AssetThumb(
                      asset: images[index], width: size, height: size)))
          : Container());
}
