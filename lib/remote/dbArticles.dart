import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/remote/settings.dart';

class DatabaseArticles {
  static String url = scriptsUrl;

  static Future<List<Article>> getAllArticles() async {
    final Response response = await get(
        Uri.parse(Uri.encodeFull(url + "articleGetAll.php")),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        });
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<Article>((article) => Article.fromJson(article))
          .toList();
    } else {
      throw Exception("Can't get articles");
    }
  }

  static Future<String> getArticle(int id) async {
    var response = await get(
        Uri.parse(Uri.encodeFull(
            articlesFolder + '/' + id.toString() + '/article.md')),
        headers: {"Accept": "application/json;charset=UTF-8"});
    return Utf8Decoder().convert(response.body.codeUnits);
  }
}
