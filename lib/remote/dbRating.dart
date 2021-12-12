import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/remote/settings.dart';

class DatabaseRating {
  static String url = scriptsUrl + 'rating/';

  static Future<String> setRating(
      int userId, double ratingVal, String ratingText) async {
    final Response response = await post(
      Uri.parse(Uri.encodeFull(url +
          "ratingSet.php/?" +
          "&&userId=" +
          userId.toString() +
          "&&ratingVal=" +
          ratingVal.toString() +
          "&&ratingText=" +
          ratingText)),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8'
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Can't add rating");
    }
  }

  static Future<List<Rating>> getRatings(int userId) async {
    final Response response = await get(
        Uri.parse(
            Uri.encodeFull(url + "ratingGet.php/?userId=" + userId.toString())),
        headers: {"Accept": "application/json;charset=UTF-8"});
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Rating>((rating) => Rating.fromJson(rating)).toList();
    } else {
      throw Exception("Can't get items");
    }
  }
}
