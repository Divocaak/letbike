import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:letbike/general/pallete.dart';
import 'package:letbike/widgets/cards/articleCard.dart';
import 'package:letbike/widgets/cards/itemCard.dart';
import 'package:letbike/widgets/errorWidgets.dart';
import 'package:letbike/widgets/images.dart';

class CardWidgets {
  static Widget cardsBuilder(
          Future<List<dynamic>>? objectsToRenderFrom, bool articleCard,
          {User? loggedUser, bool? forRating, bool? touchable}) =>
      FutureBuilder<List<dynamic>>(
          future: objectsToRenderFrom,
          builder: (context, snapshot) => (snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(child: Image.asset("assets/load.gif"))
              : (snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) => articleCard
                          ? ArticleCard.buildCard(context, snapshot.data![i])
                          : ItemCard.buildCard(context, snapshot.data![i],
                              loggedUser!, forRating!, touchable!))
                  : (snapshot.hasError
                      ? ErrorWidgets.futureBuilderError()
                      : ErrorWidgets.futureBuilderEmpty()))));

  static Widget text(
      String text, double fontSize, double offset, FontWeight fontWeight) =>FittedBox(
        child: Text(text,
            style: TextStyle(
                fontWeight: fontWeight,
                color: kWhite,
                fontSize: fontSize,
                fontFamily: "Montserrat",
                shadows: [
                  Shadow(color: kBlack, offset: Offset(offset, offset))
                ])));

  static Widget cardEssentials(Function onTap, String imgPath, Widget body) => Container(
      height: 240,
      child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          color: kWhite.withOpacity(.05),
          margin: const EdgeInsets.all(5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: InkWell(
              onTap: () => onTap(),
              child: Stack(children: [
                ServerImage()
                    .build(imgPath + "/0.jpg"),
                body
              ]))));
  
}

// ignore: must_be_immutable
class RatingBar extends StatefulWidget {
  RatingBar({key}) : super(key: key);
  double rating = 5;

  getRatingVal() => rating.toInt();

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  @override
  Widget build(BuildContext context) => Column(children: [
        Text("Hodnocení: " + widget.rating.toInt().toString(),
            style: TextStyle(color: kWhite)),
        Slider(
            value: widget.rating,
            min: 0,
            max: 10,
            divisions: 10,
            inactiveColor: kSecondaryColor,
            activeColor: kPrimaryColor,
            onChanged: (double value) => setState(
                () => widget.rating = double.parse(value.toStringAsFixed(1))))
      ]);
}
