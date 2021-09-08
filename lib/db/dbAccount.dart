import 'dart:async';
import 'package:http/http.dart';
import 'package:letbike/db/remoteSettings.dart';
import 'package:letbike/db/dbUploadImage.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class DatabaseAccount {
  static Future<String> changeAccountDetails(
      String id, List<String> values, List<Asset> images) async {
    DatabaseUploadImage.uploadImages(images, "users", id.toString());

    final Response response = await get(
        Uri.encodeFull(url +
            "userChangeDetails.php/?id=" +
            id +
            "&&fName=" +
            values[0] +
            "&&lName=" +
            values[1] +
            "&&phone=" +
            values[2] +
            "&&addA=" +
            values[3] +
            "&&addB=" +
            values[4] +
            "&&addC=" +
            values[5] +
            "&&postal=" +
            values[6]),
        headers: {"Accept": "application/json;charset=UTF-8"});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Can't register user");
    }
  }

  static Future<String> changePassword(String id, newPass, currPass) async {
    final Response response = await get(
        Uri.encodeFull(url +
            "userChangePassword.php/?id=" +
            id +
            "&&newPass=" +
            newPass +
            "&&currPass=" +
            currPass),
        headers: {"Accept": "application/json;charset=UTF-8"});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Can't register user");
    }
  }
}
