import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/remote/settings.dart';

class RemoteRatings {
  static String url = scriptsUrl + 'rating/';

  // WAITING po dodělání chatů/prodávání
  // TODO refactor
  static Future<String> setRating(
      String userId, double ratingVal, String ratingText) async {
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

  static Future<List<Rating>>? getRatings(String userId) async {
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
        : [];
  }
}
