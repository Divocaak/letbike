import 'package:flutter/material.dart';
import 'package:letbike/article/articlePage.dart';
import 'package:letbike/remote/settings.dart';
import 'package:letbike/widgets/cardWidgets.dart';

class Article {
  int id;
  String name;
  String dateAdded;

  Article(this.id, this.name, this.dateAdded);

  factory Article.fromJson(Map<String, dynamic> json) =>
      Article(int.parse(json["id"]), json["name"], json["dateAdded"]);

  Widget buildCard(context) => CardWidgets.cardEssentials(
      () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ArticlePage(article: this))),
      articlesFolder + id.toString(),
      Positioned(
          left: 16,
          bottom: 32,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardWidgets.text(name, 32, 2, FontWeight.bold),
                CardWidgets.text(dateAdded, 18, 1, FontWeight.normal)
              ])));
}
