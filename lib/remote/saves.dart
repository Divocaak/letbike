import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:letbike/general/settings.dart';

class RemoteSaves {
  static String url = scriptsUrl + 'save/';

  static Future<String?> setSave(String userId, int itemId, bool val) async {
    final Response response = await post(
        Uri.parse(Uri.encodeFull(url + "saveSet.php")),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'
        },
        body: jsonEncode(
            {"userId": userId, "itemId": itemId, "val": convertToRemote(val)}));

    return response.statusCode == 200 && response.body != "ERROR"
        ? response.body
        : null;
  }

  static Future<bool> getSave(String userId, int itemId) async {
    final Response response = await post(
        Uri.parse(Uri.encodeFull(url + "saveGet.php")),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'
        },
        body: jsonEncode({"userId": userId, "itemId": itemId}));

    return response.statusCode == 200 && response.body != "ERROR"
        ? convertToApp(response.body)
        : false;
  }

  static int convertToRemote(bool input) => input ? 1 : 0;
  static bool convertToApp(String input) => input == "1" ? true : false;
}
