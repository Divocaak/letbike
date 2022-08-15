import 'package:flutter/material.dart';
import 'package:letbike/objects/article.dart';
import 'package:letbike/widgets/new/button_main.dart';
import 'package:letbike/widgets/error_widgets.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/remote/articles.dart';
import 'package:letbike/widgets/new/page_body.dart';

class ArticlesScreen extends StatefulWidget {
  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  @override
  Widget build(BuildContext context) => PageBody(
      body: RefreshIndicator(
          onRefresh: _pullRefresh,
          color: kPrimaryColor,
          strokeWidth: 5,
          child: SizedBox.expand(
              child: FutureBuilder<List<Article>?>(
                  future: RemoteArticles.getAllArticles(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: Image.asset("assets/load.gif"));
                      default:
                        if (snapshot.hasError)
                          return ErrorWidgets.futureBuilderError();
                        else if (!snapshot.hasData ||
                            (snapshot.hasData && snapshot.data!.length < 1))
                          return ErrorWidgets.futureBuilderEmpty();
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, i) =>
                                snapshot.data![i].buildCard(context));
                    }
                  }))),
      mainButton: MainButton(
          iconData: Icons.arrow_back,
          onPressed: () => Navigator.of(context).pop()));

  Future<void> _pullRefresh() async {
    // TODO mby todo?
    widget.createState();
  }
}
