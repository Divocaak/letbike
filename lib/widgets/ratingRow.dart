import 'package:flutter/material.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/general/pallete.dart';

class RatingRow {
  static Widget buildRow(Rating rating) => SizedBox(
      height: 50,
      child: Column(children: [
        Row(children: [
          Expanded(
              flex: 2,
              child: Text(rating.value.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: kPrimaryColor))),
          Expanded(
              flex: 8,
              child: Text(rating.text, style: TextStyle(color: kWhite)))
        ]),
        Expanded(
            child: Text(rating.dateAdded,
                style: TextStyle(color: kWhite.withOpacity(.7))))
      ]));
}
