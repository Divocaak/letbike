import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letbike/general/authentification.dart';
import 'package:letbike/objects/item.dart';
import 'package:letbike/objects/rating.dart';
import 'package:letbike/remote/items.dart';
import 'package:letbike/remote/ratings.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/widgets/new/button_main.dart';
import 'package:letbike/widgets/image_server.dart';
import 'package:letbike/widgets/new/future_card_list.dart';
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

  final TextEditingController ratingController = TextEditingController();

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
                    FutureCardList(
                        buildFunction: (object) =>
                            (object as Rating).buildRow(),
                        fetchFunction: () =>
                            RemoteRatings.getRatings(widget._loggedUser.uid)),
                    FutureCardList(
                        fetchFunction: () => RemoteItems.getAllItems(1,
                            sellerId: widget._loggedUser.uid),
                        buildFunction: (object) => (object as Item)
                            .buildCard(context, widget._loggedUser)),
                    FutureCardList(
                        fetchFunction: () => RemoteItems.getAllItems(2,
                            sellerId: widget._loggedUser.uid),
                        buildFunction: (object) => (object as Item)
                            .buildCard(context, widget._loggedUser)),
                    FutureCardList(
                        fetchFunction: () => RemoteItems.getAllItems(2,
                            soldTo: widget._loggedUser.uid),
                        buildFunction: (object) => (object as Item).buildCard(
                            context, widget._loggedUser,
                            ratingController: ratingController)),
                    FutureCardList(
                        fetchFunction: () => RemoteItems.getAllItems(3,
                            soldTo: widget._loggedUser.uid),
                        buildFunction: (object) => (object as Item).buildCard(
                            context, widget._loggedUser,
                            touchable: false))
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
}
