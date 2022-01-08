import 'package:flutter/material.dart';
import 'package:letbike/general/objects/article.dart';
import 'package:letbike/widgets/errorWidgets.dart';
import 'package:letbike/widgets/mainButtonEssentials.dart';
import 'package:letbike/general/pallete.dart';
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
              child: Container(
                  color: kBlack,
                  child: FutureBuilder<List<Article>?>(
                      future: articles,
                      builder: (context, snapshot) => (snapshot
                                  .connectionState ==
                              ConnectionState.waiting
                          ? Center(child: Image.asset("assets/load.gif"))
                          : (snapshot.hasData
                              ? ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, i) =>
                                      snapshot.data![i].buildCard(context))
                              : (snapshot.hasError
                                  ? ErrorWidgets.futureBuilderError()
                                  : ErrorWidgets.futureBuilderEmpty()))))))));

  Future<void> _pullRefresh() async {
    Future<List<Article>?> _articles = RemoteArticles.getAllArticles();
    await Future.delayed(Duration(seconds: 1));
    articles = _articles;
    setState(() {});
  }
}
