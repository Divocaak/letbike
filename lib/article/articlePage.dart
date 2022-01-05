import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:letbike/general/objects/article.dart';
import 'package:letbike/remote/articles.dart';
import 'package:letbike/widgets/mainButtonEssentials.dart';
import 'package:letbike/general/pallete.dart';

double volume = 0;

class ArticlePage extends StatefulWidget {
  ArticlePage({Key? key, required Article article})
      : _article = article,
        super(key: key);

  final Article _article;

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) => Scaffold(
      floatingActionButton: MainButton(
          iconData: Icons.arrow_back,
          onPressed: () => Navigator.of(context).pop()),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: kBlack,
      body: FutureBuilder(
          future: RemoteArticles.getArticle(widget._article.id),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Container(
                  padding: EdgeInsets.fromLTRB(10, 50, 10, 50),
                  child: Markdown(
                      data: snapshot.data!,
                      styleSheet: MarkdownStyleSheet(
                          h1: TextStyle(color: kWhite),
                          h2: TextStyle(color: kWhite),
                          h3: TextStyle(color: kWhite),
                          h4: TextStyle(color: kWhite),
                          h5: TextStyle(color: kWhite),
                          h6: TextStyle(color: kWhite),
                          p: TextStyle(color: kWhite),
                          listBullet: TextStyle(color: kWhite))));
            }

            return Center(child: Image.asset("assets/load.gif"));
          }));
}
