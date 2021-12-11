import 'package:flutter/material.dart';
import 'package:letbike/user/authGate.dart';
import 'package:letbike/widgets/buttonRounded.dart';
import 'package:letbike/widgets/images.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
          body: Stack(alignment: Alignment.center, children: [
        BackgroundImage(),
        Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text("LetBike",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.bold)),
          RoundedButton(
              buttonName: "Přihlásit se",
              onClick: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AuthGate())))
        ])
      ]));
}
