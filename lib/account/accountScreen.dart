import 'package:flutter/material.dart';
import 'package:letbike/app/homePage.dart';
import 'package:letbike/db/dbItem.dart';
import 'package:letbike/db/dbRating.dart';
import 'package:letbike/db/remoteSettings.dart';
import 'package:letbike/widgets/cards/cardWidgets.dart';
import 'package:letbike/widgets/images.dart';
import 'package:letbike/widgets/ratingRow.dart';
import 'accountSettings.dart';
import 'package:letbike/general/pallete.dart';
import 'package:letbike/general/objects.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:letbike/widgets/mainButtonEssentials.dart';
import 'package:letbike/widgets/errorWidgets.dart';
import 'package:letbike/widgets/accountInfoFIeld.dart';

double volume = 0;

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
  static const routeName = "/AccountScreen";
}

class _AccountScreenState extends State<AccountScreen>
    with SingleTickerProviderStateMixin {
  Future<List<Item>> items;
  Future<List<Item>> soldItems;
  Future<List<Item>> boughtItems;
  Future<List<Item>> ratedItems;
  Future<List<Rating>> ratings;
  User user;

  AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    animationController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context).settings.arguments;
    items = DatabaseItem.getAllItems(0, user.id.toString(), {}, "sold_to");
    soldItems = DatabaseItem.getAllItems(1, user.id.toString(), {}, "sold_to");
    boughtItems =
        DatabaseItem.getAllItems(1, "seller_id", {}, user.id.toString());
    ratedItems =
        DatabaseItem.getAllItems(2, "seller_id", {}, user.id.toString());
    ratings = DatabaseRating.getRatings(user.id);
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
          ListView(
            children: [
              Center(
                  child: ServerImage.build(
                      imgsFolder + "/users/" + user.id.toString() + "/0.jpg")),
              AccountInfoField.infoField(
                  "Uživatelské jméno: " + userInfo(user.username)),
              AccountInfoField.infoField("E-mail: " + userInfo(user.email)),
              AccountInfoField.infoField(
                  "Křestní jméno: " + userInfo(user.fName)),
              AccountInfoField.infoField("Příjmení: " + userInfo(user.lName)),
              AccountInfoField.infoField(
                  "Telefon: " + userInfo(user.phone.toString())),
              AccountInfoField.infoField(
                  "Ulice a č.p.: " + userInfo(user.addressA)),
              AccountInfoField.infoField("Obec: " + userInfo(user.addressB)),
              AccountInfoField.infoField("Země: " + userInfo(user.addressC)),
              AccountInfoField.infoField(
                  "PSČ: " + userInfo(user.postal.toString())),
              Container(
                  child: CarouselSlider(
                      options: CarouselOptions(
                          aspectRatio: MediaQuery.of(context).size.width /
                              MediaQuery.of(context).size.height,
                          initialPage: 0,
                          viewportFraction: 1,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(seconds: 1)),
                      items: [
                    itemStatusField(items, "Moje inzeráty", user, false, true),
                    itemStatusField(
                        soldItems, "Prodané předměty", user, false, true),
                    itemStatusField(
                        boughtItems, "Zakoupené předměty", user, true, true),
                    itemStatusField(
                        ratedItems,
                        "Ohodnocené předměty (již přijaté, uzavřené)",
                        user,
                        false,
                        false)
                  ])),
              AccountInfoField.infoField("Hodnocení"),
              Container(
                height: 300,
                child: FutureBuilder<List<Rating>>(
                  future: ratings,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return RatingRow.buildRow(
                                snapshot.data[i].ratingValue,
                                snapshot.data[i].ratingText);
                          });
                    } else if (!snapshot.hasData) {
                      return ErrorWidgets.futureBuilderEmpty();
                    } else if (snapshot.hasError) {
                      return ErrorWidgets.futureBuilderError();
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
          MainButtonClicked(buttons: [
            SecondaryButtonData(Icons.logout,
                () => Navigator.of(context).popUntil(ModalRoute.withName('/'))),
            SecondaryButtonData(
                Icons.arrow_back,
                () => Navigator.of(context).pushReplacementNamed(
                    HomePage.routeName,
                    arguments: new HomeArguments(user, {}))),
            SecondaryButtonData(
                Icons.create,
                () => Navigator.pushReplacementNamed(
                    context, AccountSettings.routeName,
                    arguments: user)),
          ], volume: volume)
        ]));
  }

  Widget itemStatusField(Future<List<Item>> items, String label,
      User loggedUser, bool forRating, bool touchable) {
    return Column(
      children: [
        AccountInfoField.infoField(label),
        Container(
          height: 600,
          child: FutureBuilder<List<Item>>(
            future: items,
            builder: (context, snapshot) {
              return CardWidgets.cardsBuilder(items, false,
                  loggedUser: loggedUser,
                  forRating: forRating,
                  touchable: touchable);
            },
          ),
        ),
      ],
    );
  }

  String userInfo(String input) {
    return (input == "-1" ? " " : input);
  }
}
