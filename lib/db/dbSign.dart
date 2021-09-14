import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/db/remoteSettings.dart';

class DatabaseSign {
  static String url = scriptsUrl + 'sign/';

  static Future<String> registerUser(
      String username, String email, String password) async {
    final Response response = await get(
        Uri.encodeFull(url +
            "userRegister.php?username=" +
            username +
            "&&email=" +
            email +
            "&&password=" +
            password),
        headers: {"Accept": "application/json;charset=UTF-8"});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Can't register user");
    }
  }

  static Future<User> loginUser(String email, String password) async {
    final Response response = await get(
        Uri.encodeFull(
            url + "userLogin.php?email=" + email + "&&password=" + password),
        headers: {"Accept": "application/json;charset=UTF-8"});
    if (response.statusCode == 200) {
      if (response.body != "error") {
        final Map parsed = jsonDecode(response.body);
        return User.fromJson(parsed);
      } else {
        return User(-1, "", "", "", -1, -1, "", "", "", "", "", -1, -1);
      }
    } else {
      throw Exception("Can't login user");
    }
  }
}
