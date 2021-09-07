import 'package:flutter/material.dart';
import 'package:letbike/general/pallete.dart';

class AccountInfoField {
  static Widget infoField(String inputString) {
    int divider = inputString.indexOf(":", 0) + 1;
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(style: kCaptionTextStyle, children: <TextSpan>[
              TextSpan(
                  text: inputString.substring(0, divider),
                  style: TextStyle(color: kWhite)),
              TextSpan(
                  text: inputString.substring(divider, inputString.length),
                  style: TextStyle(fontWeight: FontWeight.bold, color: kWhite))
            ])));
  }
}
