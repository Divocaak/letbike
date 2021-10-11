import 'package:flutter/material.dart';
import 'package:letbike/general/pallete.dart';

class AccountInfoField {
  static Widget infoField(String inputString) {
    int divider = inputString.indexOf(":", 0) + 1;
    String value = inputString.substring(divider, inputString.length);
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: inputString.substring(0, divider),
                  style: TextStyle(color: kWhite)),
              TextSpan(
                  text: (value != " -1" ? value : " ???"),
                  style: TextStyle(fontWeight: FontWeight.bold, color: kWhite))
            ])));
  }
}
