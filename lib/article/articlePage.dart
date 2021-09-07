import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../general/general.dart';
import 'package:letbike/widgets/mainButtonEssentials.dart';

double volume = 0;

class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState();
  static const routeName = "/articlePage";
}

class _ArticlePageState extends State<ArticlePage>
    with SingleTickerProviderStateMixin {
  Article articleInfo;

  AnimationController animationController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    articleInfo = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        floatingActionButton: MainButton(
            iconData: Icons.arrow_back,
            onPressed: () => Navigator.of(context).pop()),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        backgroundColor: kBlack,
        body: FutureBuilder(
            future: DatabaseServices.getArticle(articleInfo.id),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return Container(
                    padding: EdgeInsets.fromLTRB(10, 50, 10, 50),
                    child: Markdown(
                      data: snapshot.data,
                      styleSheet: MarkdownStyleSheet(
                          h1: TextStyle(color: kWhite),
                          h2: TextStyle(color: kWhite),
                          h3: TextStyle(color: kWhite),
                          h4: TextStyle(color: kWhite),
                          h5: TextStyle(color: kWhite),
                          h6: TextStyle(color: kWhite),
                          p: TextStyle(color: kWhite),
                          listBullet: TextStyle(color: kWhite)),
                    ));
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
