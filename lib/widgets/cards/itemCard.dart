import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letbike/remote/items.dart';
import 'package:letbike/remote/ratings.dart';
import 'package:letbike/remote/settings.dart';
import 'package:letbike/general/pallete.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/item/itemPage.dart';
import 'package:letbike/widgets/alertBox.dart';
import 'package:letbike/widgets/errorWidgets.dart';
import 'cardWidgets.dart';

TextEditingController ratingController = TextEditingController();

class ItemCard {
  static Widget buildCard(context, Item item, User loggedUser, bool forRating,
          bool touchable) =>
      CardWidgets.cardEssentials(
          () => onCardClick(context, item, loggedUser, forRating, touchable),
          imgsFolder +
              "items/" +
              loggedUser.uid +
              item.name.hashCode.toString(),
          Column(children: [
            Expanded(
                flex: 1,
                child: CardWidgets.text(item.name, 32, 2, FontWeight.bold)),
            Expanded(flex: 3, child: Container()),
            Expanded(
                flex: 1,
                child: Row(children: [
                  Expanded(
                      flex: 4,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: CardWidgets.text(item.description ?? "", 18, 1,
                              FontWeight.normal))),
                  Expanded(
                      flex: 2,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: CardWidgets.text(item.price.toString() + "Kč",
                              24, 2, FontWeight.bold)))
                ]))
          ]));

  static void onCardClick(
      context, Item item, User loggedUser, bool forRating, bool touchable) {
    if (touchable) {
      if (!forRating) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ItemPage(item: item, loggedUser: loggedUser)));
      } else {
        RatingBar ratingBar = RatingBar();
        ModalWindow.showModalWindow(
            context,
            "Ohodnoťte prodejce",
            Container(
                width: 500,
                height: 500,
                child: ListView(children: [
                  Text(
                      "Prodejce ohodnoťte až poté, co Vám přijde zakoupený předmět.",
                      style: TextStyle(color: kWhite)),
                  ratingBar,
                  Expanded(
                      child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 10,
                          maxLength: 100,
                          style: TextStyle(color: kWhite),
                          controller: ratingController,
                          decoration: InputDecoration(
                              hintText: "Ohodnoťte uživatele a předmět",
                              hintStyle: TextStyle(color: kWhite),
                              counterStyle: TextStyle(color: kWhite),
                              border: new OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide: new BorderSide(color: kWhite)))))
                ])), after: () {
          Future<bool?> rateResponse = RemoteRatings.setRating(
              item.sellerId, ratingBar.getRatingVal(), ratingController.text);
          ModalWindow.showModalWindow(
              context,
              "Oznámení",
              FutureBuilder<bool?>(
                  future: rateResponse,
                  builder: (context, snapshot) =>
                      (snapshot.connectionState == ConnectionState.waiting
                          ? Center(child: Image.asset("assets/load.gif"))
                          : (snapshot.hasData
                              ? Text("Uživatel ohodnocen.",
                                  style: TextStyle(color: kWhite))
                              : (snapshot.hasError
                                  ? ErrorWidgets.futureBuilderError()
                                  : ErrorWidgets.futureBuilderEmpty())))),
              after: () {
            RemoteItems.updateItemStatus(item.id, 3, soldTo: item.soldTo);
            Navigator.of(context).pop();
          });
        });
      }
    }
  }
}
