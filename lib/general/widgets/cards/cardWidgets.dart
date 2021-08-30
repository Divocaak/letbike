import "package:flutter/material.dart";
import '../../pallete.dart';

class CardWidgets {
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
