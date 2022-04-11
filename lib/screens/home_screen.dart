import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letbike/objects/item.dart';
import 'package:letbike/screens/add_item_screen.dart';
import 'package:letbike/remote/items.dart';
import 'package:letbike/screens/user_screen.dart';
import 'package:letbike/screens/filter_screen.dart';
import 'package:letbike/screens/articles_screen.dart';
import 'package:letbike/widgets/button_main.dart';
import 'package:letbike/widgets/error_widgets.dart';
import 'package:letbike/widgets/button_main_clicked.dart';
import 'package:letbike/general/settings.dart';

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
  late Future<List<Item>?> items;

  late AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    animationController.addListener(() => setState(() {}));
    items = RemoteItems.getAllItems(1, itemParams: widget._filters);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: kBlack,
        body: Stack(children: [
          SafeArea(
              child: RefreshIndicator(
                  onRefresh: _pullRefresh,
                  backgroundColor: Colors.transparent,
                  color: kPrimaryColor,
                  strokeWidth: 5,
                  child: SizedBox.expand(
                      child: FutureBuilder<List<Item>?>(
                          future: items,
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Center(
                                    child: Image.asset("assets/load.gif"));
                              default:
                                if (snapshot.hasError) {
                                  return ErrorWidgets.futureBuilderError();
                                } else if (!snapshot.hasData ||
                                    (snapshot.hasData &&
                                        snapshot.data!.length < 1))
                                  return ErrorWidgets.futureBuilderEmpty();
                                return ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, i) =>
                                        snapshot.data![i].buildCard(
                                            context, widget._loggedUser));
                            }
                          })))),
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

  Future<void> _pullRefresh() async {
    Future<List<Item>?> _items =
        RemoteItems.getAllItems(1, itemParams: widget._filters);
    await Future.delayed(Duration(seconds: 1));
    items = _items;
    setState(() {});
  }
}
