import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:letbike/general/settings.dart';

class MyAd {
  bool loaded;
  final NativeAd ad;

  MyAd(this.loaded, this.ad);

  Widget buildAd() => loaded
      ? SizedBox(
          height: 150,
          child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 0,
              color: kWhite.withOpacity(.2),
              margin: const EdgeInsets.all(5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: AdWidget(ad: ad)))
      : const CircularProgressIndicator();
}
