import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:letbike/settings.dart';

class RemoteUser {
  static Future<int> checkUserStatus(
      String id, String name, String mail) async {
    final Response response = await post(
        Uri.parse(Uri.encodeFull(scriptsUrl + "checkUser.php")),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode({"userId": id, "name": name, "mail": mail}));

    return response.statusCode == 200 && response.body != "ERROR"
        ? int.parse(response.body)
        : 0;
  }
}
