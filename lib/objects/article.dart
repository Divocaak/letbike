import 'package:flutter/material.dart';
import 'package:letbike/screens/article_screen.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/widgets/card_body.dart';
import 'package:letbike/widgets/card_text.dart';

class Article {
  int id;
  String name;
  String dateAdded;

  Article(this.id, this.name, this.dateAdded);

  factory Article.fromJson(Map<String, dynamic> json) =>
      Article(int.parse(json["id"]), json["name"], json["dateAdded"]);

  Widget buildCard(context) => CardBody(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ArticlePage(article: this))),
      imgPath: articlesFolder + id.toString(),
      child: Positioned(
          left: 16,
          bottom: 32,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardText(text: name, fontSize: 32, offset: 2, fontWeight: FontWeight.bold),
                CardText(text: dateAdded, fontSize: 18)
              ])));
}
