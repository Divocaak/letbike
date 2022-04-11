import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:letbike/screens/first_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) =>
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
              .then((_) => runApp(LetBike())));
}

class LetBike extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      MaterialApp(title: 'LetBike', home: FirstScreen());
}
