import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:letbike/sign/screens/register.dart';
import '../general/general.dart';

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
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    animationController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    articleInfo = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            backgroundColor: kBlack,
            body: FutureBuilder(
                future: DatabaseServices.getArticle(articleInfo.id),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
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
                }),
          ),
          IgnorePointer(
            ignoring: volume == 0 ? true : false,
            child: Container(
              color: Colors.black.withOpacity(volume),
              child: Stack(
                children: [
                  Positioned(
                      bottom: 120,
                      right: 120,
                      child: CircularButton(
                          kSecondaryColor.withOpacity(volume * 2),
                          45,
                          Icons.arrow_back,
                          kWhite.withOpacity(volume * 2), () {
                        Navigator.of(context).pop();
                      })),
                ],
              ),
            ),
          ),
          Positioned(
              height: 275,
              width: 275,
              right: -75,
              bottom: -75,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CircularButton(kPrimaryColor, 60, Icons.menu, kWhite, () {
                    if (animationController.isCompleted) {
                      animationController.reverse();
                      volume = 0;
                    } else {
                      animationController.forward();
                      volume = 0.5;
                    }
                  })
                ],
              ))
        ],
      ),
    );
  }
}
