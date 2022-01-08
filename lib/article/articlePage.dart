import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:letbike/general/objects/article.dart';
import 'package:letbike/remote/articles.dart';
import 'package:letbike/widgets/mainButtonEssentials.dart';
import 'package:letbike/general/pallete.dart';

class ArticlePage extends StatelessWidget {
  ArticlePage({Key? key, required Article article})
      : _article = article,
        super(key: key);
  final Article _article;

  @override
  Widget build(BuildContext context) => Scaffold(
      floatingActionButton: MainButton(
          iconData: Icons.arrow_back,
          onPressed: () => Navigator.of(context).pop()),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: kBlack,
      body: SafeArea(
          child: FutureBuilder(
              future: RemoteArticles.getArticle(_article.id),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                      padding: EdgeInsets.fromLTRB(10, 50, 10, 50),
                      child: Markdown(
                          data: snapshot.data!,
                          styleSheet: MarkdownStyleSheet(
                              h1: TextStyle(color: kPrimaryColor),
                              h2: TextStyle(color: kSecondaryColor),
                              h3: TextStyle(color: kPrimaryColor),
                              h4: TextStyle(color: kSecondaryColor),
                              h5: TextStyle(color: kPrimaryColor),
                              h6: TextStyle(color: kSecondaryColor),
                              p: TextStyle(color: kWhite),
                              blockquoteDecoration: BoxDecoration(
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.lerp(kBlack, Colors.white, .2)),
                              listBullet: TextStyle(color: kWhite))));
                }

                return Center(child: Image.asset("assets/load.gif"));
              })));
}
