import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:letbike/objects/article.dart';
import 'package:letbike/remote/articles.dart';
import 'package:letbike/widgets/new/button_main.dart';
import 'package:letbike/widgets/error_widgets.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/widgets/new/page_body.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key, required Article article})
      : _article = article,
        super(key: key);
  final Article _article;

  @override
  Widget build(BuildContext context) => PageBody(
      body: FutureBuilder<String?>(
          future: RemoteArticles.getArticle(_article.id),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: Image.asset("assets/load.gif"));
              default:
                if (snapshot.hasError) {
                  return ErrorWidgets.futureBuilderError();
                } else if (!snapshot.hasData) {
                  return ErrorWidgets.futureBuilderEmpty();
                }
                return Markdown(
                    data: snapshot.data!,
                    styleSheet: MarkdownStyleSheet(
                        h1: const TextStyle(color: kPrimaryColor),
                        h2: const TextStyle(color: kSecondaryColor),
                        h3: const TextStyle(color: kPrimaryColor),
                        h4: const TextStyle(color: kSecondaryColor),
                        h5: const TextStyle(color: kPrimaryColor),
                        h6: const TextStyle(color: kSecondaryColor),
                        p: const TextStyle(color: kWhite),
                        blockquoteDecoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                            color: Color.lerp(kBlack, kWhite, .2)),
                        listBullet: const TextStyle(color: kWhite)));
            }
          }),
      mainButton: MainButton(iconData: Icons.arrow_back, onPressed: () => Navigator.of(context).pop()));
}
