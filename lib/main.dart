import 'package:flutter/material.dart';
import 'package:letbike/firstScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(LetBike());
}

class LetBike extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      MaterialApp(title: 'LetBike', home: FirstScreen());
}
