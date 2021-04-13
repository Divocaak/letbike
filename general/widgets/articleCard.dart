import 'package:flutter/material.dart';
import '../general.dart';
import '../../article/articlePage.dart';

class ArticleCard {
  static Widget buildCard(context, Article article) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: Colors.white.withOpacity(.05),
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Ink(
            child: InkWell(
              child: FadeInImage.assetNetwork(
                  fit: BoxFit.fill,
                  placeholder: "Načítám obrázek (možná neexsituje :/)",
                  image:
                      articlesFolder + "/" + article.id.toString() + "/0.jpg"),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(ArticlePage.routeName, arguments: article);
              },
            ),
            height: 240,
            padding: const EdgeInsets.all(50),
          ),
          Positioned(
            left: 16,
            bottom: 32,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    article.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 32,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(4, 1),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    article.added,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(4, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
