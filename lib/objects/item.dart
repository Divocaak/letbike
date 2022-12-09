import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/objects/params/param_item.dart';
import 'package:letbike/objects/person.dart';
import 'package:letbike/screens/item_screen.dart';
import 'package:letbike/remote/items.dart';
import 'package:letbike/remote/ratings.dart';
import 'package:letbike/widgets/alert_box.dart';
import 'package:letbike/widgets/card_body.dart';
import 'package:letbike/widgets/card_text.dart';
import 'package:letbike/widgets/error_widgets.dart';
import 'package:letbike/widgets/rating_bar.dart';

class Item {
  int id;
  Person seller;
  Person? buyer;
  String name;
  String? description;
  int price;
  String dateStart;
  String? dateEnd;
  String imgs;
  int status;
  List<ParamItem> params;

  Item(
      this.id,
      this.seller,
      this.buyer,
      this.name,
      this.description,
      this.price,
      this.dateStart,
      this.dateEnd,
      this.imgs,
      this.status,
      this.params);

  factory Item.fromJson(Map<String, dynamic> json) => Item(
      json["id"],
      Person.fromJson(json["seller"]),
      json["buyer"] != null ? Person.fromJson(json["buyer"]) : null,
      json["name"],
      json["description"],
      json["price"],
      json["dateStart"],
      json["dateEnd"],
      json["imgs"],
      json["status"],
      getParams(json["params"]));

  static List<ParamItem> getParams(Map<String, dynamic> json) {
    List<ParamItem> toRet = [];
    json.forEach((key, value) => toRet.add(ParamItem(key, value)));
    return toRet;
  }

  Widget buildParamsBlock() {
    List<Widget> chips = [];
    params.forEach((element) => chips.add(element.buildChip()));
    return chips.length > 0
        ? Padding(
            padding: const EdgeInsets.all(10),
            child: Wrap(
                spacing: 10, alignment: WrapAlignment.center, children: chips))
        : Container();
  }

  Widget buildCard(context, User loggedUser,
          {bool touchable = true, TextEditingController? ratingController}) =>
      CardBody(
          onTap: () => onCardClick(context, loggedUser,
              touchable: touchable, ratingController: ratingController),
          imgPath: imgsFolder + "items/" + seller.id + name.hashCode.toString(),
          child: Column(children: [
            Expanded(
                flex: 1,
                child: CardText(
                    text: name,
                    fontSize: 32,
                    offset: 2,
                    fontWeight: FontWeight.bold)),
            Expanded(flex: 3, child: Container()),
            Expanded(
                flex: 1,
                child: Row(children: [
                  Expanded(
                      flex: 4,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child:
                              CardText(text: description ?? "", fontSize: 18))),
                  Expanded(
                      flex: 2,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: CardText(
                              text: price.toString() + "Kč",
                              fontSize: 24,
                              offset: 2,
                              fontWeight: FontWeight.bold)))
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
            ]),
            after: () => ModalWindow.showModalWindow(
                    context,
                    "Oznámení",
                    FutureBuilder<bool?>(
                        future: RemoteRatings.setRating(seller.id,
                            ratingBar.getRatingVal(), ratingController.text),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(
                                  child: Image.asset("assets/load.gif"));
                            default:
                              if (snapshot.hasError)
                                return ErrorWidgets.futureBuilderError();
                              else if (!snapshot.hasData)
                                return ErrorWidgets.futureBuilderEmpty();
                              return Text("Uživatel ohodnocen.",
                                  style: TextStyle(color: kWhite));
                          }
                        }), after: () {
                  RemoteItems.updateItemStatus(id, 3, soldTo: buyer?.id);
                  Navigator.of(context).pop();
                }));
      }
    }
  }
}
