import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letbike/remote/items.dart';
import 'package:letbike/remote/ratings.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/general/pallete.dart';
import 'package:letbike/user/signGate.dart';
import 'package:letbike/widgets/accountInfoField.dart';
import 'package:letbike/widgets/cards/cardWidgets.dart';
import 'package:letbike/widgets/errorWidgets.dart';
import 'package:letbike/widgets/images.dart';
import 'package:letbike/widgets/mainButtonEssentials.dart';
import 'package:letbike/widgets/ratingRow.dart';

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
  late Future<List<Item>>? items;
  late Future<List<Item>>? soldItems;
  late Future<List<Item>>? boughtItems;
  late Future<List<Item>>? ratedItems;
  late Future<List<Rating>>? ratings;

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
    items = RemoteItems.getAllItems(1, sellerId: widget._loggedUser.uid);
    soldItems = RemoteItems.getAllItems(2, sellerId: widget._loggedUser.uid);
    boughtItems = RemoteItems.getAllItems(2, soldTo: widget._loggedUser.uid);
    ratedItems = RemoteItems.getAllItems(3, soldTo: widget._loggedUser.uid);
    ratings = RemoteRatings.getRatings(widget._loggedUser.uid);

    return Scaffold(
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
          ListView(children: [
            Center(
                child: ServerImage().build(widget._loggedUser.photoURL ?? "")),
            AccountInfoField.infoField(
                "E-mail: " + (widget._loggedUser.email ?? "")),
            AccountInfoField.infoField(
                "Jméno a příjmení: " + (widget._loggedUser.displayName ?? "")),
            AccountInfoField.infoField(
                "Telefon: " + (widget._loggedUser.phoneNumber ?? "")),
            AccountInfoField.infoField("Hodnocení"),
            Container(
                height: 200,
                child: FutureBuilder<List<Rating>>(
                    future: ratings,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: Image.asset("assets/load.gif"));
                      } else {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, i) =>
                                  RatingRow.buildRow(snapshot.data![i]));
                        } else if (snapshot.hasError) {
                          return ErrorWidgets.futureBuilderError();
                        } else {
                          return ErrorWidgets.futureBuilderEmpty();
                        }
                      }
                    })),
            Container(
                child:
                    CarouselSlider(options: carouselOptions(context), items: [
              itemStatusField(items!, "Moje inzeráty", touchable: true),
              itemStatusField(soldItems!, "Prodané předměty", touchable: true),
              itemStatusField(boughtItems!, "Zakoupené předměty",
                  forRating: true, touchable: true),
              itemStatusField(
                  ratedItems!, "Ohodnocené předměty (již přijaté, uzavřené)")
            ]))
          ]),
          MainButtonClicked(buttons: [
            SecondaryButtonData(Icons.logout, () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignGate()));
            }),
            SecondaryButtonData(
                Icons.arrow_back, () => Navigator.of(context).pop())
          ], volume: volume)
        ]));
  }

  Widget itemStatusField(Future<List<Item>> items, String label,
          {bool? forRating, bool? touchable}) =>
      Column(children: [
        AccountInfoField.infoField(label),
        Container(
            height: 350,
            child: FutureBuilder<List<Item>>(
                future: items,
                builder: (context, snapshot) => CardWidgets.cardsBuilder(
                    items, false,
                    loggedUser: widget._loggedUser,
                    forRating: forRating ?? false,
                    touchable: touchable ?? false)))
      ]);
}
