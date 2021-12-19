import 'package:flutter/material.dart';
import 'package:letbike/widgets/cards/cardWidgets.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/article/articlePage.dart';
import 'package:letbike/remote/settings.dart';

class ArticleCard {
  static Widget buildCard(context, Article article) =>
      CardWidgets.cardEssentials(
          () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ArticlePage(article: article))),
          articlesFolder + article.id.toString(),
          Positioned(
              left: 16,
              bottom: 32,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardWidgets.text(article.name, 32, 2, FontWeight.bold),
                    CardWidgets.text(
                        article.dateAdded, 18, 1, FontWeight.normal)
                  ])));
}
