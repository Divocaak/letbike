import 'package:flutter/material.dart';
import 'package:letbike/objects/article.dart';
import 'package:letbike/widgets/button_main.dart';
import 'package:letbike/widgets/error_widgets.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/remote/articles.dart';

class ArticlesScreen extends StatefulWidget {
  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen>
    with SingleTickerProviderStateMixin {
  late Future<List<Article>?> articles;

  @override
  void initState() {
    articles = RemoteArticles.getAllArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      floatingActionButton: MainButton(
          iconData: Icons.arrow_back,
          onPressed: () => Navigator.of(context).pop()),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: kBlack,
      body: SafeArea(
          child: RefreshIndicator(
              onRefresh: _pullRefresh,
              backgroundColor: Colors.transparent,
              color: kPrimaryColor,
              strokeWidth: 5,
              child: SizedBox.expand(
                  child: FutureBuilder<List<Article>?>(
                      future: articles,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(
                                child: Image.asset("assets/load.gif"));
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
                      })))));

  Future<void> _pullRefresh() async {
    Future<List<Article>?> _articles = RemoteArticles.getAllArticles();
    await Future.delayed(Duration(seconds: 1));
    articles = _articles;
    setState(() {});
  }
}
