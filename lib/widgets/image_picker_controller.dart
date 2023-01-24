import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

// TODO APP IMGPICKER rework (extends State, wtf?)
class ImagePickerController extends State {
  @override
  build(context) => Container();

  Future<int> checkPerm() async {
    var status = await Permission.camera.status;
    if (status == PermissionStatus.denied) {
      await Permission.camera.request();
    }

    if (status == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    }

    return Permission.camera.value;
  }

  loadAssets(State<dynamic> state, List<XFile>? images, int maxImages, bool mounted, context,
      Function(List<XFile>) setImages) async {
    state.setState(() => images = []);
    List<XFile>? resultList;
    String? error;

    if (await checkPerm() == 1) {
      try {
        resultList = await ImagePicker().pickMultiImage(imageQuality: 75, requestFullMetadata: false);
        // TODO APP IMGPICKER max images
      } on Exception catch (e) {
        error = e.toString();
      }

      if (!mounted) return;

      if (resultList != null) {
        state.setState(() => images = resultList);
        setImages(resultList);
      }

      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Chyba: $error")));
      }
    }
  }

// TODO APP IMGPICKER show selected
  Widget buildGridView(List<XFile>? images, int crossAxisCount, int size) => (images != null
      ? GridView.count(
          crossAxisCount: crossAxisCount,
          children: List.generate(images.length,
              (index) => const Text("todo") /* AssetThumb(asset: images[index], width: size, height: size) */))
      : Container());
}
