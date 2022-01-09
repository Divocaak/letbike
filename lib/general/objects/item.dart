import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letbike/general/categories.dart';
import 'package:letbike/general/pallete.dart';
import 'package:letbike/item/itemPage.dart';
import 'package:letbike/remote/items.dart';
import 'package:letbike/remote/ratings.dart';
import 'package:letbike/remote/settings.dart';
import 'package:letbike/widgets/alertBox.dart';
import 'package:letbike/widgets/cardWidgets.dart';
import 'package:letbike/widgets/errorWidgets.dart';

class Item {
  int id;
  String sellerId;
  String? soldTo;
  String name;
  String? description;
  int price;
  String dateStart;
  String? dateEnd;
  String imgs;
  int status;
  Map<String, dynamic>? itemParams;

  Item(
      this.id,
      this.sellerId,
      this.soldTo,
      this.name,
      this.description,
      this.price,
      this.dateStart,
      this.dateEnd,
      this.imgs,
      this.status,
      this.itemParams);

  factory Item.fromJson(Map<String, dynamic> json) => Item(
      int.parse(json["id"]),
      json["sellerId"],
      json["soldTo"],
      json["name"],
      json["description"],
      int.parse(json["price"]),
      json["dateStart"],
      json["dateEnd"],
      json["imgs"],
      int.parse(json["status"]),
      json["params"]);

  Widget buildParams(BuildContext context) {
    List<String> keys = itemParams!.keys.toList();
    List<dynamic> values = itemParams!.values.toList();
    return ListView.builder(
        itemCount: itemParams!.length,
        itemBuilder: (context, i) => Row(children: [
              Expanded(
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      color: kPrimaryColor,
                      child: Text(ParamRow.params[keys[i]]!.name,
                          style: TextStyle(color: kWhite),
                          textAlign: TextAlign.center))),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      color: kSecondaryColor,
                      child: Text(
                          ParamRow.params[keys[i]]!.options[
                              (values[i] == "true" || values[i] == "false")
                                  ? (values[i] == "false" ? 0 : 1)
                                  : int.parse(values[i])],
                          style: TextStyle(color: kWhite),
                          textAlign: TextAlign.center))),
            ]));
  }

  Widget buildCard(context, User loggedUser,
          {bool touchable = true, TextEditingController? ratingController}) =>
      CardWidgets.cardEssentials(
          () => onCardClick(context, loggedUser,
              touchable: touchable, ratingController: ratingController),
          imgsFolder + "items/" + sellerId + name.hashCode.toString(),
          Column(children: [
            Expanded(
                flex: 1, child: CardWidgets.text(name, 32, 2, FontWeight.bold)),
            Expanded(flex: 3, child: Container()),
            Expanded(
                flex: 1,
                child: Row(children: [
                  Expanded(
                      flex: 4,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: CardWidgets.text(
                              description ?? "", 18, 1, FontWeight.normal))),
                  Expanded(
                      flex: 2,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: CardWidgets.text(
                              price.toString() + "Kč", 24, 2, FontWeight.bold)))
                ]))
          ]));

  void onCardClick(context, User loggedUser,
      {bool touchable = true, TextEditingController? ratingController}) {
    if (touchable) {
      if (ratingController == null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ItemPage(item: this, loggedUser: loggedUser)));
      } else {
        RatingBar ratingBar = RatingBar();
        ModalWindow.showModalWindow(
            context,
            "Ohodnoťte prodejce",
            ListView(children: [
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
            ]), after: () {
          Future<bool?> rateResponse = RemoteRatings.setRating(
              sellerId, ratingBar.getRatingVal(), ratingController.text);
          ModalWindow.showModalWindow(
              context,
              "Oznámení",
              FutureBuilder<bool?>(
                  future: rateResponse,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: Image.asset("assets/load.gif"));
                      default:
                        if (snapshot.hasError)
                          return ErrorWidgets.futureBuilderError();
                        else if (!snapshot.hasData)
                          return ErrorWidgets.futureBuilderEmpty();
                        return Text("Uživatel ohodnocen.",
                            style: TextStyle(color: kWhite));
                    }
                  }), after: () {
            RemoteItems.updateItemStatus(id, 3, soldTo: soldTo);
            Navigator.of(context).pop();
          });
        });
      }
    }
  }
}
