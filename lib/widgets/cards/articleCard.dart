import 'package:flutter/material.dart';
import 'package:letbike/widgets/cards/cardWidgets.dart';
import 'package:letbike/general/pallete.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/article/articlePage.dart';
import 'package:letbike/widgets/images.dart';
import 'package:letbike/remote/settings.dart';

class ArticleCard {
  static Widget buildCard(context, Article article) {
    return Container(
        height: 240,
        child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 0,
            color: kWhite.withOpacity(.05),
            margin: const EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
                onTap: () => Navigator.of(context)
                    .pushNamed(ArticlePage.routeName, arguments: article),
                child: Stack(children: [
                  ServerImage().build(
                      articlesFolder + "/" + article.id.toString() + "/0.jpg"),
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
