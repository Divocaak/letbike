import 'package:flutter/material.dart';
import 'package:letbike/widgets/cards/cardWidgets.dart';
import 'package:letbike/widgets/mainButtonEssentials.dart';
import 'package:letbike/general/pallete.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/remote/articles.dart';

class ArticlesScreen extends StatefulWidget {
  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen>
    with SingleTickerProviderStateMixin {
  late Future<List<Article>>? articles;

  @override
  Widget build(BuildContext context) {
    articles = RemoteArticles.getAllArticles();
    return Scaffold(
        floatingActionButton: MainButton(
            iconData: Icons.arrow_back,
            onPressed: () => Navigator.of(context).pop()),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Container(
            color: kBlack, child: CardWidgets.cardsBuilder(articles, true)));
  }
}
