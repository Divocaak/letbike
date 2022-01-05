import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF75c8cc);
const kSecondaryColor = Color(0xFFaedfdb);
const kWhite = Color(0xFFf2f2f2);
const kBlack = Color(0xFF1a1a1a);
const kError = Color(0xFFFF101F);
const kWarning = Color(0xFFFFFC31);
const kGreen = Color(0xFF50C878);

const TextStyle kSignLinkButton =
    TextStyle(fontSize: 22, color: Colors.white, height: 1.5);

const TextStyle kMainButtonStyle = TextStyle(color: kBlack);
const TextStyle kCaptionTextSatyle = TextStyle(color: Colors.purple);

CarouselOptions carouselOptions(context) =>
    CarouselOptions(height: 1000, viewportFraction: .925, autoPlay: true);
