import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/user/signGate.dart';
import 'package:letbike/widgets/buttonRounded.dart';
import 'package:letbike/widgets/images.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
          body: Stack(alignment: Alignment.center, children: [
        BackgroundImage(),
        SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              Expanded(
                  flex: 3,
                  child: Column(children: [
                    Text("LetBike",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 60,
                            fontWeight: FontWeight.bold)),
                    Flexible(
                        child: Container(
                            margin: EdgeInsets.all(100),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Image.asset("assets/icon.png")))
                  ])),
              Flexible(
                  child: RoundedButton(
                      buttonName: "Přihlásit se",
                      onClick: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => SignGate())))),
              Flexible(
                  child: RoundedButton(
                      buttonName: "Navštívit web",
                      color: kSecondaryColor,
                      sizeMultiplier: .06,
                      onClick: () => General.openUrl(baseUrl)))
            ]))
      ]));
}
