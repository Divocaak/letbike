import 'package:flutter/material.dart';
import 'package:letbike/account/accountScreen.dart';
import 'package:letbike/db/dbItem.dart';
import 'package:letbike/db/dbRating.dart';
import 'package:letbike/db/remoteSettings.dart';
import 'package:letbike/general/pallete.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/item/itemPage.dart';
import 'package:letbike/widgets/alertBox.dart';
import 'package:letbike/widgets/images.dart';
import 'cardWidgets.dart';

TextEditingController ratingController = TextEditingController();
double rating = 50;

class ItemCard {
  static Widget buildCard(
      context, Item item, User loggedUser, bool forRating, bool touchable) {
    return Container(
        height: 240,
        child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 0,
            color: kWhite.withOpacity(.05),
            margin: const EdgeInsets.all(5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: InkWell(
                onTap: () => onCardClick(
                    context, item, loggedUser, forRating, touchable),
                child: Stack(children: [
                  ServerImage().build(imgsFolder +
                      "/items/" +
                      (item.name.hashCode + item.sellerId).toString() +
                      "/0.jpg"),
                  Column(children: [
                    Expanded(
                        flex: 1,
                        child: CardWidgets.text(
                            item.name, 32, 2, FontWeight.bold)),
                    Expanded(flex: 3, child: Container()),
                    Expanded(
                        flex: 1,
                        child: Row(children: [
                          Expanded(
                              flex: 4,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: CardWidgets.text(item.description, 18,
                                      1, FontWeight.normal))),
                          Expanded(
                              flex: 2,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: CardWidgets.text(
                                      item.price.toString() + "Kč",
                                      24,
                                      2,
                                      FontWeight.bold)))
                        ]))
                  ])
                ]))));
  }

  static void onCardClick(
      context, Item item, User loggedUser, bool forRating, bool touchable) {
    if (touchable) {
      if (!forRating) {
        Navigator.of(context).pushNamed(ItemPage.routeName,
            arguments: new ItemInfo(item, loggedUser));
      } else {
        ModalWindow.showModalWindow(
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
                    RatingBar(rating),
                    Expanded(
                        child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 10,
                            maxLength: 250,
                            style: TextStyle(color: kWhite),
                            controller: ratingController,
                            decoration: InputDecoration(
                                hintText: "Ohodnoťte uživatele a předmět",
                                hintStyle: TextStyle(color: kWhite),
                                counterStyle: TextStyle(color: kWhite),
                                border: new OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide: new BorderSide(color: kWhite),
                                ))))
                  ],
                )), after: () {
          Future<String> rateResponse = DatabaseRating.setRating(
              item.sellerId, rating, ratingController.text);
          ModalWindow.showModalWindow(
              context,
              "Oznámení",
              FutureBuilder<String>(
                future: rateResponse,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data, style: TextStyle(color: kWhite));
                  } else if (snapshot.hasError) {
                    return Text('Sorry there is an error',
                        style: TextStyle(color: kWhite));
                  }
                  return Center(child: Image.asset("assets/load.gif"));
                },
              ), after: () {
            DatabaseItem.updateItemStatus(item.id, 2, item.soldTo);
            Navigator.of(context).pushReplacementNamed(AccountScreen.routeName,
                arguments: loggedUser);
          });
        });
      }
    }
  }
}
