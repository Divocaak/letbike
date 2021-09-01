import "package:flutter/material.dart";
import 'package:letbike/general/general.dart';
import '../../pallete.dart';

class CardWidgets {
  static Widget cardsBuilder(
      Future<List<dynamic>> objectsToRenderFrom, bool articleCard,
      {User loggedUser, bool forRating, bool touchable}) {
    return FutureBuilder<List<dynamic>>(
        future: objectsToRenderFrom,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return articleCard
                      ? ArticleCard.buildCard(context, snapshot.data[i])
                      : ItemCard.buildCard(context, snapshot.data[i],
                          loggedUser, forRating, touchable);
                });
          } else if (!snapshot.hasData) {
            return ErrorWidgets.futureBuilderEmpty();
          } else if (snapshot.hasError) {
            return ErrorWidgets.futureBuilderError();
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  static Widget text(
      String text, double fontSize, double offset, FontWeight fontWeight) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight,
        color: kWhite,
        fontSize: fontSize,
        fontFamily: "Montserrat",
        shadows: [
          Shadow(
            color: kBlack,
            offset: Offset(offset, offset),
          ),
        ],
      ),
    );
  }
}

class RatingBar extends StatefulWidget {
  RatingBar(this.rating, {key}) : super(key: key);
  double rating;

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Hodnocení: " + widget.rating.toString(),
          style: TextStyle(color: kWhite),
        ),
        Slider(
          value: widget.rating,
          min: 0,
          max: 100,
          inactiveColor: kSecondaryColor,
          activeColor: kPrimaryColor,
          onChanged: (double value) {
            setState(() {
              widget.rating = double.parse(value.toStringAsFixed(1));
            });
          },
        )
      ],
    );
  }
}
