import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:letbike/general/settings.dart';

// TODO APP L8R fix
class AdHandler extends StatefulWidget {
  AdHandler({Key? key}) : super(key: key);

  final Map<int, Map<String, dynamic>> ads = {};
  void initAds() => MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(testDeviceIds: ['33BE2250B43518CCDA7DE426D04EE231', '0faf99b3cf596954617f26a2639b9681']));

  @override
  AdHandlerState createState() => AdHandlerState();
}

class AdHandlerState extends State<AdHandler> {
  @override
  Widget build(BuildContext context) {
    int i = 4;
    Map<String, dynamic>? currentAd = widget.ads[i];
    if ((i + 1) % 3 == 0) {
      if (currentAd == null) {
        currentAd = {};
        currentAd["loaded"] = false;
        currentAd["ad"] = NativeAd(
            adUnitId: Platform.isAndroid
                ? "ca-app-pub-8451063166378874/4317911543"
                : "ca-app-pub-8451063166378874/2462469041",
            factoryId: "listTile",
            listener: NativeAdListener(
                onAdLoaded: (Ad ad) => setState(() => currentAd!["loaded"] = true),
                onAdFailedToLoad: (ad, e) {
                  ad.dispose();
                  print(e);
                }),
            request: const AdRequest());
        currentAd["ad"].load();
      }

      return currentAd["loaded"]
          ? SizedBox(
              height: 150,
              child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 0,
                  color: kWhite.withOpacity(.2),
                  margin: const EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: AdWidget(ad: currentAd["ad"])))
          : const CircularProgressIndicator();
    } else {
      return Container();
    }
  }
}
