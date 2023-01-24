import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:letbike/screens/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => MobileAds.instance.initialize().then((__) => runApp(const LetBike())));
}

class LetBike extends StatelessWidget {
  const LetBike({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(title: 'LetBike', home: SignInScreen());
}
