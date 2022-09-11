import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letbike/general/authentification.dart';
import 'package:letbike/objects/rating.dart';
import 'package:letbike/remote/items.dart';
import 'package:letbike/remote/ratings.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/widgets/new/button_main.dart';
import 'package:letbike/widgets/error_widgets.dart';
import 'package:letbike/widgets/image_server.dart';
import 'package:letbike/widgets/item_column.dart';
import 'package:letbike/widgets/new/button_main_sub.dart';
import 'package:letbike/widgets/new/page_body.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key, required User loggedUser})
      : _loggedUser = loggedUser,
        super(key: key);

  final User _loggedUser;
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // ignore: unused_field
  // TODO vymyslet s tim boolem neco
  bool _isSigningOut = false;

  // TODO ukrast na homepage
  //late Future<List<Item>?> savedItems;
  //savedItems = RemoteItems.getAllItems(1, saverId: widget._loggedUser.uid);
  late Future<List<Rating>?> ratings;

  final TextEditingController ratingController = TextEditingController();

  @override
  void initState() {
    ratings = RemoteRatings.getRatings(widget._loggedUser.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => PageBody(
      body: Column(children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ServerImage(path: widget._loggedUser.photoURL ?? ""),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // TODO style
                        Text(widget._loggedUser.email ?? "",
                            style: TextStyle(color: kWhite)),
                        Text(widget._loggedUser.displayName ?? "",
                            style: TextStyle(color: kWhite))
                      ])
                ])),
        Expanded(
            child: DefaultTabController(
                length: 5,
                child: Column(children: [
                  ButtonsTabBar(
                      backgroundColor: kPrimaryColor,
                      unselectedBackgroundColor: kSecondaryColor,
                      labelStyle: TextStyle(color: kWhite),
                      unselectedLabelStyle: TextStyle(color: kWhite),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      tabs: [
                        Tab(icon: Icon(Icons.reviews), text: "Hodnocení"),
                        Tab(
                            icon: Icon(Icons.directions_bike),
                            text: "Moje inzeráty"),
                        Tab(icon: Icon(Icons.sell), text: "Prodané"),
                        Tab(icon: Icon(Icons.shopping_cart), text: "Zakoupené"),
                        Tab(icon: Icon(Icons.done), text: "Ohodnocené")
                      ]),
                  Expanded(
                      child: TabBarView(children: [
                    Expanded(
                        child: FutureBuilder<List<Rating>?>(
                            future: ratings,
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return Center(
                                      child: Image.asset("assets/load.gif"));
                                default:
                                  if (snapshot.hasError)
                                    return ErrorWidgets.futureBuilderError();
                                  else if (!snapshot.hasData ||
                                      (snapshot.hasData &&
                                          snapshot.data!.length < 1))
                                    return ErrorWidgets.futureBuilderEmpty();
                                  return ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, i) =>
                                          snapshot.data![i].buildRow());
                              }
                            })),
                    ItemColumn(
                        user: widget._loggedUser,
                        itemStatus: 1,
                        sellerId: widget._loggedUser.uid),
                    ItemColumn(
                        user: widget._loggedUser,
                        itemStatus: 2,
                        sellerId: widget._loggedUser.uid),
                    ItemColumn(
                        user: widget._loggedUser,
                        itemStatus: 2,
                        soldTo: widget._loggedUser.uid,
                        ratingController: ratingController),
                    ItemColumn(
                        user: widget._loggedUser,
                        itemStatus: 3,
                        soldTo: widget._loggedUser.uid,
                        touchable: false)
                  ]))
                ])))
      ]),
      mainButton: MainButton(secondaryButtons: [
        MainButtonSub(
            icon: Icons.logout,
            label: "Odhlásit se",
            onClick: () async {
              setState(() => _isSigningOut = true);
              await Authentication.signOut(context: context);
              setState(() => _isSigningOut = false);
            }),
        MainButtonSub(
            icon: Icons.arrow_back,
            label: "Zpět",
            onClick: () => Navigator.of(context).pop())
      ]));

  Future<void> _pullRefresh() async {
    Future<List<Rating>?> _ratings =
        RemoteRatings.getRatings(widget._loggedUser.uid);
    await Future.delayed(Duration(seconds: 1));
    ratings = _ratings;
    setState(() {});
  }
}
