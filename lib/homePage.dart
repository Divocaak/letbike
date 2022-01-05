import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letbike/general/objects/item.dart';
import 'package:letbike/item/addItem.dart';
import 'package:letbike/remote/items.dart';
import 'package:letbike/user/userPage.dart';
import 'package:letbike/filters/filters.dart';
import 'package:letbike/article/articlesScreen.dart';
import 'package:letbike/widgets/errorWidgets.dart';
import 'package:letbike/widgets/mainButtonEssentials.dart';
import 'package:letbike/general/pallete.dart';

double volume = 0;

class HomePage extends StatefulWidget {
  HomePage({Key? key, required User loggedUser, Map<String, String>? filters})
      : _loggedUser = loggedUser,
        _filters = filters,
        super(key: key);

  final User _loggedUser;
  final Map<String, String>? _filters;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late Future<List<Item>>? items;

  late AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    animationController.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    items = RemoteItems.getAllItems(1, itemParams: widget._filters);
    return Scaffold(
        floatingActionButton: MainButton(
            iconData: Icons.menu,
            onPressed: () {
              if (animationController.isCompleted) {
                animationController.reverse();
                volume = 0;
              } else {
                animationController.forward();
                volume = 0.5;
              }
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Stack(children: [
          Container(
              color: kBlack,
              child: FutureBuilder<List<dynamic>>(
                  future: items,
                  builder: (context, snapshot) =>
                      (snapshot.connectionState == ConnectionState.waiting
                          ? Center(child: Image.asset("assets/load.gif"))
                          : (snapshot.hasData
                              ? ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, i) => snapshot.data![i]
                                      .buildCard(context, widget._loggedUser))
                              : (snapshot.hasError
                                  ? ErrorWidgets.futureBuilderError()
                                  : ErrorWidgets.futureBuilderEmpty()))))),
          MainButtonClicked(buttons: [
            SecondaryButtonData(
                Icons.add,
                () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        AddItem(loggedUser: widget._loggedUser)))),
            SecondaryButtonData(
                Icons.filter_alt,
                () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        FilterPage(loggedUser: widget._loggedUser)))),
            SecondaryButtonData(
                Icons.person,
                () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        UserPage(loggedUser: widget._loggedUser)))),
            SecondaryButtonData(
                Icons.article,
                () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ArticlesScreen())))
          ], volume: volume)
        ]));
  }
}
