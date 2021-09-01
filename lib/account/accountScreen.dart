import 'package:flutter/material.dart';
import 'package:letbike/app/homePage.dart';
import 'package:letbike/general/widgets/cards/cardWidgets.dart';
import 'package:letbike/general/widgets/ratingRow.dart';
import 'accountSettings.dart';
import '../general/general.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
    items = DatabaseServices.getAllItems(
        0, user.id.toString(), ItemParams.createEmpty(), "sold_to");
    soldItems = DatabaseServices.getAllItems(
        1, user.id.toString(), ItemParams.createEmpty(), "sold_to");
    boughtItems = DatabaseServices.getAllItems(
        1, "seller_id", ItemParams.createEmpty(), user.id.toString());
    ratedItems = DatabaseServices.getAllItems(
        2, "seller_id", ItemParams.createEmpty(), user.id.toString());
    ratings = DatabaseServices.getRatings(user.id);
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
                  child: FadeInImage.assetNetwork(
                      imageErrorBuilder: (BuildContext context,
                          Object exception, StackTrace stackTrace) {
                        return ErrorWidgets.imageLoadingError(Icons.person);
                      },
                      placeholder: "Načítám obrázek (možná neexsituje :/)",
                      image: imgsFolder +
                          "/users/" +
                          user.id.toString() +
                          "/0.jpg")),
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
                    arguments:
                        new HomeArguments(user, ItemParams.createEmpty()))),
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
