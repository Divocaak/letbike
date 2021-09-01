import 'package:flutter/material.dart';
import 'package:letbike/general/widgets/cards/cardWidgets.dart';
import '../general/general.dart';
import '../app/homePage.dart';

class ArticlesScreen extends StatefulWidget {
  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
  static const routeName = "/articlesScreen";
}

class _ArticlesScreenState extends State<ArticlesScreen>
    with SingleTickerProviderStateMixin {
  Future<List<Article>> articles;

  HomeArguments homeArguments;

  @override
  Widget build(BuildContext context) {
    homeArguments = ModalRoute.of(context).settings.arguments;
    articles = DatabaseServices.getAllArticles();
    return Scaffold(
        floatingActionButton: MainButton(
            iconData: Icons.arrow_back,
            onPressed: () => Navigator.of(context).pushReplacementNamed(
                HomePage.routeName,
                arguments: homeArguments)),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Container(
            color: kBlack, child: CardWidgets.cardsBuilder(articles, true)));
  }
}
