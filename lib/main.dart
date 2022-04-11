import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:letbike/screens/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) =>
          MobileAds.instance.initialize().then((__) => runApp(LetBike())));
}

class LetBike extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      MaterialApp(title: 'LetBike', home: SignInScreen());
}
