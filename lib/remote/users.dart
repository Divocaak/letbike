import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
import 'package:letbike/remote/settings.dart';

class RemoteUser {
  static Future<int> checkUserStatus(String id) async {
    print("id to post: " + id);
    final Response response = await post(
        Uri.parse(Uri.encodeFull(scriptsUrl + "checkUser.php")),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, String>{'userId': id, "pls": "ano"}));

    print(response.body);
    return response.statusCode == 200 && response.body != "ERROR"
        ? int.parse(response.body)
        : 0;
  }
}
