import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:letbike/general/settings.dart';

class RemoteUser {
  static Future<int?> checkUserStatus(String id, String name, String mail) async {
    final Response response = await post(Uri.parse(Uri.encodeFull(scriptsUrl + "user/check")),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode({"id_user": id, "name": name, "mail": mail}));

    return response.statusCode == 200 ? jsonDecode(response.body)["id_status"] : null;
  }
}
