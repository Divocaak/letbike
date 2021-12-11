import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:letbike/db/remoteSettings.dart';
import 'package:letbike/general/pallete.dart';
import 'package:letbike/homePage.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:letbike/widgets/images.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Stack(alignment: Alignment.center, children: [
        StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SignInScreen(
                    headerBuilder: (context, constraints, _) =>
                        BackgroundImage(),
                    footerBuilder: (context, _) {
                      return Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: TextButton(
                              onPressed: () => openUrl("terms.pdf"),
                              child: Container(
                                  child: Text(
                                      "Přihlášením souhlasíte s podmínkami",
                                      style: TextStyle(color: kBlack)),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1, color: kBlack))))));
                    },
                    showAuthActionSwitch: false,
                    providerConfigs: [
                      GoogleProviderConfiguration(clientId: "clientId"),
                      //AppleProviderConfiguration()
                    ]);
              }

              return HomePage(loggedUser: snapshot.data as User);
            })
      ]);

  static void openUrl(String doc) async {
    String url = docsFolder + "/" + doc;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Nelze otevřít.';
    }
  }
}
