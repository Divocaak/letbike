import 'package:flutter/material.dart';
import 'package:letbike/app/homePage.dart';
import 'package:letbike/general/widgets/ratingRow.dart';
import 'accountSettings.dart';
import '../general/general.dart';

double volume = 0;
int textHeight = 50;

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
        body: Stack(children: [
          ListView(
            padding: const EdgeInsets.all(5),
            children: [
              Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 50),
                  child: Center(
                      child: FadeInImage.assetNetwork(
                          placeholder: "Načítám obrázek (možná neexsituje :/)",
                          image: imgsFolder +
                              "/users/" +
                              user.id.toString() +
                              "/0.jpg"))),
              AccountInfoField.infoField("Uživatelské jméno: " + user.username),
              AccountInfoField.infoField("E-mail: " + user.email),
              AccountInfoField.infoField("Křestní jméno: " + user.fName),
              AccountInfoField.infoField("Příjmení: " + user.lName),
              AccountInfoField.infoField("Telefon: " + user.phone.toString()),
              AccountInfoField.infoField("Ulice a č.p.: " + user.addressA),
              AccountInfoField.infoField("Obec: " + user.addressB),
              AccountInfoField.infoField("Země: " + user.addressC),
              AccountInfoField.infoField("PSČ: " + user.postal.toString()),
              AccountInfoField.infoField("Moje inzeráty:"),
              Container(
                height: 300,
                width: 600,
                child: FutureBuilder<List<Item>>(
                  future: items,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return ItemCard.buildCard(
                                context, snapshot.data[i], user, false, true);
                          });
                    } else if (!snapshot.hasData) {
                      return Container(
                          alignment: Alignment.topCenter,
                          child: Text("Zatím tu nic není :(",
                              style: TextStyle(color: kWhite)));
                    } else if (snapshot.hasError) {
                      return Text('Sorry there is an error',
                          style: TextStyle(color: kWhite));
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              AccountInfoField.infoField("Prodané předměty:"),
              Container(
                height: 300,
                width: 600,
                child: FutureBuilder<List<Item>>(
                  future: soldItems,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return ItemCard.buildCard(
                                context, snapshot.data[i], user, false, true);
                          });
                    } else if (!snapshot.hasData) {
                      return Container(
                          alignment: Alignment.topCenter,
                          child: Text("Zatím tu nic není :(",
                              style: TextStyle(color: kWhite)));
                    } else if (snapshot.hasError) {
                      return Text('Sorry there is an error',
                          style: TextStyle(color: kWhite));
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              AccountInfoField.infoField("Zakoupené předměty:"),
              Container(
                height: 300,
                width: 600,
                child: FutureBuilder<List<Item>>(
                  future: boughtItems,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return ItemCard.buildCard(
                                context, snapshot.data[i], user, true, true);
                          });
                    } else if (!snapshot.hasData) {
                      return Container(
                          alignment: Alignment.topCenter,
                          child: Text("Zatím tu nic není :(",
                              style: TextStyle(color: kWhite)));
                    } else if (snapshot.hasError) {
                      return Text('Sorry there is an error',
                          style: TextStyle(color: kWhite));
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              AccountInfoField.infoField(
                  "Ohodnocené předměty (již přijaté, uzavřené):"),
              Container(
                height: 300,
                width: 600,
                child: FutureBuilder<List<Item>>(
                  future: ratedItems,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return ItemCard.buildCard(
                                context, snapshot.data[i], user, false, false);
                          });
                    } else if (!snapshot.hasData) {
                      return Container(
                          alignment: Alignment.topCenter,
                          child: Text("Zatím tu nic není :(",
                              style: TextStyle(color: kWhite)));
                    } else if (snapshot.hasError) {
                      return Text('Sorry there is an error',
                          style: TextStyle(color: kWhite));
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              AccountInfoField.infoField("Hodnocení: "),
              Container(
                height: 300,
                width: 400,
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
                      return Container(
                          alignment: Alignment.topCenter,
                          child: Text("Zatím tu nic není :(",
                              style: TextStyle(color: kWhite)));
                    } else if (snapshot.hasError) {
                      return Text('Sorry there is an error',
                          style: TextStyle(color: kWhite));
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
          IgnorePointer(
            ignoring: volume == 0 ? true : false,
            child: Container(
              color: Colors.black.withOpacity(volume),
              child: Stack(
                children: [
                  Positioned(
                      bottom: 40,
                      right: 150,
                      child: CircularButton(
                          kSecondaryColor.withOpacity(volume * 2),
                          45,
                          Icons.logout,
                          kWhite.withOpacity(volume * 2), () {
                        Navigator.of(context)
                            .popUntil(ModalRoute.withName('/'));
                      })),
                  Positioned(
                      bottom: 120,
                      right: 120,
                      child: CircularButton(
                          kSecondaryColor.withOpacity(volume * 2),
                          45,
                          Icons.arrow_back,
                          kWhite.withOpacity(volume * 2), () {
                        Navigator.of(context).pushReplacementNamed(
                            HomePage.routeName,
                            arguments: new HomeArguments(
                                user, ItemParams.createEmpty()));
                      })),
                  Positioned(
                      bottom: 150,
                      right: 40,
                      child: CircularButton(
                          kSecondaryColor.withOpacity(volume * 2),
                          45,
                          Icons.create,
                          kWhite.withOpacity(volume * 2), () {
                        Navigator.pushReplacementNamed(
                            context, AccountSettings.routeName,
                            arguments: user);
                      })),
                ],
              ),
            ),
          ),
          Positioned(
              height: 275,
              width: 275,
              right: -75,
              bottom: -75,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CircularButton(kPrimaryColor, 60, Icons.menu, kWhite, () {
                    if (animationController.isCompleted) {
                      animationController.reverse();
                      volume = 0;
                    } else {
                      animationController.forward();
                      volume = 0.5;
                    }
                  })
                ],
              ))
        ]));
  }
}
