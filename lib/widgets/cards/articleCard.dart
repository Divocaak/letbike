import 'package:flutter/material.dart';
import 'package:letbike/widgets/cards/cardWidgets.dart';
import 'package:letbike/general/general.dart';
import 'package:letbike/article/articlePage.dart';

class ArticleCard {
  static Widget buildCard(context, Article article) {
    return Container(
        height: 240,
        child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 0,
            color: Colors.white.withOpacity(.05),
            margin: const EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
                onTap: () => Navigator.of(context)
                    .pushNamed(ArticlePage.routeName, arguments: article),
                child: Stack(children: [
                  FadeInImage.assetNetwork(
                      fit: BoxFit.fill,
                      placeholder: "Načítám obrázek (možná neexsituje :/)",
                      image: articlesFolder +
                          "/" +
                          article.id.toString() +
                          "/0.jpg"),
                  Positioned(
                      left: 16,
                      bottom: 32,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CardWidgets.text(
                                article.title, 32, 2, FontWeight.bold),
                            CardWidgets.text(
                                article.added, 18, 1, FontWeight.normal)
                          ]))
                ]))));
  }
}
