import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:letbike/screens/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(LetBike()));
}

class LetBike extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      MaterialApp(title: 'LetBike', home: SignInScreen());
}
