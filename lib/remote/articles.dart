import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:letbike/general/objects/article.dart';
import 'package:letbike/remote/settings.dart';

class RemoteArticles {
  static Future<List<Article>>? getAllArticles() async {
    final Response response = await get(
        Uri.parse(Uri.encodeFull(scriptsUrl + "articleGetAll.php")),
        headers: {HttpHeaders.contentTypeHeader: "application/json"});

    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .cast<Map<String, dynamic>>()
          .map<Article>((article) => Article.fromJson(article))
          .toList();
    } else {
      return [];
    }
  }

  static Future<String>? getArticle(int id) async {
    var response = await get(
        Uri.parse(Uri.encodeFull(
            articlesFolder + '/' + id.toString() + '/article.md')),
        headers: {HttpHeaders.acceptHeader: "application/json;charset=UTF-8"});
    return Utf8Decoder().convert(response.body.codeUnits);
  }
}
