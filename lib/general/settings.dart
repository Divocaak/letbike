import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

const String baseUrl = 'http://letbike.xf.cz/';
const String imgsFolder = baseUrl + 'imgs/';
const String articlesFolder = baseUrl + 'articles/';
const String docsFolder = baseUrl + 'docs/';
const String scriptsUrl = baseUrl + 'scripts/app/';
const String imgUploadEndPoint = scriptsUrl + 'uploadImage.php';

class General {
  static void openUrl(String url) async {
    Uri uri = Uri.parse(Uri.encodeFull(url));
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Nelze otevřít.';
    }
  }
}
