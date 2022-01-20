import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:letbike/objects/article.dart';
import 'package:letbike/remote/articles.dart';
import 'package:letbike/widgets/button_main.dart';
import 'package:letbike/widgets/error_widgets.dart';
import 'package:letbike/general/settings.dart';

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
          child: SizedBox.expand(
              child: FutureBuilder<String?>(
                  future: RemoteArticles.getArticle(_article.id),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: Image.asset("assets/load.gif"));
                      default:
                        if (snapshot.hasError)
                          return ErrorWidgets.futureBuilderError();
                        else if (!snapshot.hasData)
                          return ErrorWidgets.futureBuilderEmpty();
                        return Markdown(
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
                                    border:
                                        Border.all(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        Color.lerp(kBlack, Colors.white, .2)),
                                listBullet: TextStyle(color: kWhite)));
                    }
                  }))));
}
