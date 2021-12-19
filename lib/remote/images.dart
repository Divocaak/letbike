import 'dart:convert';
import 'package:http/http.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:letbike/remote/settings.dart';

class RemoteImages {
  static uploadImages(
      List<Asset> images, String imgFolder, String folderIdentificator) async {
    var request = MultipartRequest('POST', Uri.parse(imgUploadEndPoint));

    for (int i = 0; i < images.length; i++) {
      var byteData = await images[i].getByteData();
      List<int> imageData = byteData.buffer.asUint8List();

      request.fields["img" + i.toString()] = base64Encode(imageData);
    }

    request.fields["imgCount"] = images.length.toString();
    request.fields["imgFolder"] = imgFolder;
    request.fields["folderIdentificator"] = folderIdentificator;

    var res = await request.send();
    if (res.statusCode != 200) {
      print("error");
    }
  }
}
