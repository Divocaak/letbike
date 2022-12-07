import 'package:flutter/material.dart';
import 'package:letbike/general/authentification.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/widgets/button_rounded.dart';
import 'package:letbike/widgets/google_sign_in_button.dart';
import 'package:letbike/widgets/image_background.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                  child: FutureBuilder(
                      future:
                          Authentication.initializeFirebase(context: context),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error initializing Firebase');
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          return GoogleSignInButton();
                        }
                        return CircularProgressIndicator();
                      })),
              Flexible(
                  child: Column(children: [
                RoundedButton(
                    label: "Obchodní podmínky",
                    color: kSecondaryColor,
                    sizeMultiplier: .06,
                    onClick: () => General.openUrl(docsFolder + "terms.pdf")),
                SizedBox(height: 10),
                RoundedButton(
                    label: "Navštívit web",
                    color: kSecondaryColor,
                    sizeMultiplier: .06,
                    onClick: () => General.openUrl(baseUrl))
              ]))
            ]))
      ]));
}
