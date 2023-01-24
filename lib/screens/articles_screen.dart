import 'package:flutter/material.dart';
import 'package:letbike/objects/article.dart';
import 'package:letbike/widgets/new/button_main.dart';
import 'package:letbike/remote/articles.dart';
import 'package:letbike/widgets/new/future_card_list.dart';
import 'package:letbike/widgets/new/page_body.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => PageBody(
      body: FutureCardList(
          buildFunction: (object) => (object as Article).buildCard(context),
          fetchFunction: () => RemoteArticles.getAllArticles()),
      mainButton: MainButton(iconData: Icons.arrow_back, onPressed: () => Navigator.of(context).pop()));
}
