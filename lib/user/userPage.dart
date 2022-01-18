import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letbike/firstScreen.dart';
import 'package:letbike/general/objects/item.dart';
import 'package:letbike/general/objects/rating.dart';
import 'package:letbike/remote/items.dart';
import 'package:letbike/remote/ratings.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/widgets/accountInfoField.dart';
import 'package:letbike/widgets/errorWidgets.dart';
import 'package:letbike/widgets/images.dart';
import 'package:letbike/widgets/mainButtonEssentials.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key, required User loggedUser})
      : _loggedUser = loggedUser,
        super(key: key);

  final User _loggedUser;
  @override
  _UserPageState createState() => _UserPageState();
}

double volume = 0;

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  late Future<List<Item>?> items;
  late Future<List<Item>?> savedItems;
  late Future<List<Item>?> soldItems;
  late Future<List<Item>?> boughtItems;
  late Future<List<Item>?> ratedItems;
  late Future<List<Rating>?> ratings;

  late AnimationController animationController;

  final TextEditingController ratingController = TextEditingController();

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    animationController.addListener(() => setState(() {}));
    items = RemoteItems.getAllItems(1, sellerId: widget._loggedUser.uid);
    savedItems = RemoteItems.getAllItems(1, saverId: widget._loggedUser.uid);
    soldItems = RemoteItems.getAllItems(2, sellerId: widget._loggedUser.uid);
    boughtItems = RemoteItems.getAllItems(2, soldTo: widget._loggedUser.uid);
    ratedItems = RemoteItems.getAllItems(3, soldTo: widget._loggedUser.uid);
    ratings = RemoteRatings.getRatings(widget._loggedUser.uid);

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: kBlack,
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
        SafeArea(
            child: Column(children: [
          Flexible(
              flex: 1,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ServerImage(path: widget._loggedUser.photoURL ?? ""),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AccountInfoField(
                              text: widget._loggedUser.email ?? ""),
                          AccountInfoField(
                              text: widget._loggedUser.displayName ?? "")
                        ])
                  ])),
          Flexible(
              flex: 3,
              child: RefreshIndicator(
                  onRefresh: _pullRefresh,
                  backgroundColor: Colors.transparent,
                  color: kPrimaryColor,
                  strokeWidth: 5,
                  child:
                      CarouselSlider(options: carouselOptions(context), items: [
                    Column(children: [
                      AccountInfoField(text: "Hodnocení"),
                      Expanded(
                          child: SizedBox.expand(
                              child: FutureBuilder<List<Rating>?>(
                                  future: ratings,
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        return Center(
                                            child:
                                                Image.asset("assets/load.gif"));
                                      default:
                                        if (snapshot.hasError)
                                          return ErrorWidgets
                                              .futureBuilderError();
                                        else if (!snapshot.hasData ||
                                            (snapshot.hasData &&
                                                snapshot.data!.length < 1))
                                          return ErrorWidgets
                                              .futureBuilderEmpty();
                                        return ListView.builder(
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (context, i) =>
                                                snapshot.data![i].buildRow());
                                    }
                                  })))
                    ]),
                    itemStatusField(items, "Moje inzeráty"),
                    itemStatusField(savedItems, "Uložené inzeráty"),
                    itemStatusField(soldItems, "Prodané předměty"),
                    itemStatusField(boughtItems, "Zakoupené předměty",
                        ratingController: ratingController),
                    itemStatusField(ratedItems,
                        "Ohodnocené předměty (již přijaté, uzavřené)",
                        touchable: false)
                  ])))
        ])),
        MainButtonClicked(buttons: [
          SecondaryButtonData(Icons.logout, () async {
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => FirstScreen()));
          }),
          SecondaryButtonData(
              Icons.arrow_back, () => Navigator.of(context).pop())
        ], volume: volume)
      ]));

  Widget itemStatusField(Future<List<Item>?> items, String label,
          {bool touchable = true, TextEditingController? ratingController}) =>
      Column(children: [
        AccountInfoField(text: label),
        Expanded(
            child: SizedBox.expand(
                child: FutureBuilder<List<Item>?>(
                    future: items,
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
                              itemBuilder: (context, i) => snapshot.data![i]
                                  .buildCard(context, widget._loggedUser,
                                      touchable: touchable,
                                      ratingController: ratingController));
                      }
                    })))
      ]);

  Future<void> _pullRefresh() async {
    Future<List<Item>?> _items =
        RemoteItems.getAllItems(1, sellerId: widget._loggedUser.uid);
    Future<List<Item>?> _soldItems =
        RemoteItems.getAllItems(2, sellerId: widget._loggedUser.uid);
    Future<List<Item>?> _boughtItems =
        RemoteItems.getAllItems(2, soldTo: widget._loggedUser.uid);
    Future<List<Item>?> _ratedItems =
        RemoteItems.getAllItems(3, soldTo: widget._loggedUser.uid);
    Future<List<Rating>?> _ratings =
        RemoteRatings.getRatings(widget._loggedUser.uid);
    await Future.delayed(Duration(seconds: 1));
    items = _items;
    soldItems = _soldItems;
    boughtItems = _boughtItems;
    ratedItems = _ratedItems;
    ratings = _ratings;
    setState(() {});
  }
}
