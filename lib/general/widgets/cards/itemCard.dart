import 'package:flutter/material.dart';
import 'package:letbike/account/accountScreen.dart';
import '../../../app/itemPage.dart';
import '../../general.dart';
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
            color: Colors.white.withOpacity(.05),
            margin: const EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
                onTap: () => onCardClick(
                    context, item, loggedUser, forRating, touchable),
                child: Stack(children: [
                  FadeInImage.assetNetwork(
                      fit: BoxFit.fill,
                      placeholder: "Načítám obrázek (možná neexsituje :/)",
                      image: imgsFolder +
                          "/items/" +
                          (item.name.hashCode + item.sellerId).toString() +
                          "/0.jpg"),
                  Positioned(
                      left: 16,
                      bottom: 32,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CardWidgets.text(item.name, 32, 2, FontWeight.bold),
                            CardWidgets.text(
                                item.description, 18, 1, FontWeight.normal)
                          ])),
                  Positioned(
                      right: 16,
                      bottom: 16,
                      child: CardWidgets.text(item.price.toString() + "Kč", 32,
                          2, FontWeight.bold)),
                ]))));
  }

  static void onCardClick(
      context, Item item, User loggedUser, bool forRating, bool touchable) {
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
          Future<String> rateResponse = DatabaseServices.setRating(
              item.sellerId, rating, ratingController.text);
          AlertBox.showAlertBox(
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
                  return Center(child: CircularProgressIndicator());
                },
              ), after: () {
            DatabaseServices.updateItemStatus(item.id, 2, item.soldTo);
            Navigator.of(context).pushReplacementNamed(AccountScreen.routeName,
                arguments: loggedUser);
          });
        });
      }
    }
  }
}
