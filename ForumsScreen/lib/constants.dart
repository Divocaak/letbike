import 'package:flutter/material.dart';


const kDarkPrimaryColor = Color(0xFF212121);
const kDarkSecondaryColor = Color(0xFF373737);
const kLightPrimaryColor = Color(0xFFFFFFFF);
const kLightSecondaryColor = Color(0xFFF3F7FB);
const kAccentColor = Colors.greenAccent;

final kTitleTextStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

final kCaptionTextStyle = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w400,
);

final kButtonTextStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);

final kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'SFProText',
  primaryColor: kDarkPrimaryColor,
  canvasColor: kDarkPrimaryColor,
  backgroundColor: kDarkSecondaryColor,
  accentColor: kAccentColor,
  iconTheme: ThemeData.dark().iconTheme.copyWith(
        color: kLightSecondaryColor,
      ),
  textTheme: ThemeData.dark().textTheme.apply(
        fontFamily: 'SFProText',
        bodyColor: kLightSecondaryColor,
        displayColor: kLightSecondaryColor,
      ),
);
