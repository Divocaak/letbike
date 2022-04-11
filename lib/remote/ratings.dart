import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:letbike/objects/rating.dart';
import 'package:letbike/settings.dart';

class RemoteRatings {
  static String url = scriptsUrl + 'rating/';

  static Future<bool?> setRating(String userId, int val, String text) async {
    final Response response = await post(
        Uri.parse(Uri.encodeFull(url + "ratingSet.php")),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'
        },
        body: jsonEncode(
            {"userId": userId, "val": val.toString(), "text": text}));

    return response.statusCode == 200 && response.body != "ERROR" ? true : null;
  }

  static Future<List<Rating>?> getRatings(String userId) async {
    final Response response = await post(
        Uri.parse(Uri.encodeFull(url + "ratingGet.php")),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'
        },
        body: jsonEncode({"userId": userId}));

    return response.statusCode == 200 && response.body != "ERROR"
        ? jsonDecode(response.body)
            .cast()
            .map<Rating>((rating) => Rating.fromJson(rating))
            .toList()
        : null;
  }
}
