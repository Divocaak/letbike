import 'package:flutter/material.dart';
import 'package:letbike/settings.dart';

class Rating {
  int value;
  String text;
  String dateAdded;

  Rating(this.value, this.text, this.dateAdded);

  factory Rating.fromJson(Map<String, dynamic> json) =>
      Rating(int.parse(json["val"]), json["text"], json["date"]);

  Widget buildRow() => SizedBox(
      height: 50,
      child: Column(children: [
        Row(children: [
          Expanded(
              flex: 2,
              child: Text(value.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: kPrimaryColor))),
          Expanded(flex: 8, child: Text(text, style: TextStyle(color: kWhite)))
        ]),
        Expanded(
            child: Text(dateAdded,
                style: TextStyle(color: kWhite.withOpacity(.7))))
      ]));
}
