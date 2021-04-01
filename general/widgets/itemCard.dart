import 'package:flutter/material.dart';
import 'package:letbike/account/accountScreen.dart';
import '../../app/itemPage.dart';
import '../general.dart';

TextEditingController ratingController = TextEditingController();
double rating = 50;

class ItemCard {
  static Widget buildCard(
      context, Item item, User loggedUser, bool forRating, bool touchable) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: Colors.white.withOpacity(.05),
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Ink(
            child: InkWell(
              child: FadeInImage.assetNetwork(
                  fit: BoxFit.fill,
                  placeholder: "Načítám obrázek (možná neexsituje :/)",
                  image: imgsFolder +
                      "/items/" +
                      (item.name.hashCode + item.sellerId).toString() +
                      "/0.jpg"),
              onTap: () {
                if (touchable) {
                  if (!forRating) {
                    Navigator.of(context).pushNamed(ItemPage.routeName,
                        arguments: new ItemInfo(item, loggedUser));
                  } else {
                    AlertBox.showAlertBox(
                        context,
                        "Ohodnoťte prodejce",
                        Container(
                            width: 500,
                            height: 500,
                            child: ListView(
                              children: [
                                Text(
                                    "Prodejce ohodnoťte až poté, co Vám přijde zakoupený předmět.",
                                    style: TextStyle(color: kWhite)),
                                RatingBar(),
                                Expanded(
                                    child: TextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 10,
                                        maxLength: 250,
                                        controller: ratingController,
                                        decoration: InputDecoration(
                                            hintText:
                                                "Ohodnoťte uživatele a předmět",
                                            border: new OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25)),
                                              borderSide:
                                                  new BorderSide(color: kBlack),
                                            ))))
                              ],
                            )), after: () {
                      Future<String> rateResponse = DatabaseServices.setRating(
                          item.sellerId, rating, ratingController.text);
                      AlertBox.showAlertBox(
                          context,
                          "Oznámení",
                          FutureBuilder<String>(
                            future: rateResponse,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data,
                                    style: TextStyle(color: kWhite));
                              } else if (snapshot.hasError) {
                                return Text('Sorry there is an error',
                                    style: TextStyle(color: kWhite));
                              }
                              return Center(child: CircularProgressIndicator());
                            },
                          ), after: () {
                        DatabaseServices.updateItemStatus(
                            item.id, 2, item.soldTo);
                        Navigator.of(context).pushReplacementNamed(
                            AccountScreen.routeName,
                            arguments: loggedUser);
                      });
                    });
                  }
                }
              },
            ),
            height: 240,
            padding: const EdgeInsets.all(50),
          ),
          Positioned(
            left: 16,
            bottom: 32,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    item.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 32,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(4, 1),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    item.description,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(4, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 16,
            bottom: 32,
            child: Container(
              child: Text(
                item.price.toString() + "Kč",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 32,
                  fontFamily: "Montserrat",
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(4, 1),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RatingBar extends StatefulWidget {
  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Hodnocení: " + rating.toString()),
        Slider(
          value: rating,
          min: 0,
          max: 100,
          inactiveColor: kSecondaryColor,
          activeColor: kPrimaryColor,
          onChanged: (double value) {
            setState(() {
              rating = double.parse(value.toStringAsFixed(1));
            });
          },
        )
      ],
    );
  }

  static double getSliderVal() {
    return rating;
  }
}
