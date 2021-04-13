import 'package:flutter/material.dart';
import '../pallete.dart';

class RatingRow {
  static Widget buildRow(double ratingVal, String ratingText) {
    return SizedBox(
        child: Row(children: [
      Expanded(
          flex: 2,
          child: Text(
            ratingVal.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryColor),
          )),
      Expanded(
          flex: 8, child: Text(ratingText, style: TextStyle(color: kWhite)))
    ]));
  }
}
