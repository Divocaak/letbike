import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/objects/params/param.dart';

class RemoteParams {
  static Future<List<Param>?> getParams() async {
    final Response response = await get(Uri.parse(Uri.encodeFull(scriptsUrl + "schema/schema")));

    return response.statusCode == 200 && response.body != "ERROR"
        ? jsonDecode(response.body).map<Param>((data) => Param.fromJson(data)).toList()
        : null;
  }
}
