import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:letbike/general/settings.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:letbike/screens/auth_screen.dart';
import 'package:letbike/widgets/image_background.dart';

class SignGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Stack(alignment: Alignment.center, children: [
        StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              print("aaa");
              print(snapshot.data);
              if (!snapshot.hasData) {
                return SignInScreen(
                    headerBuilder: (context, constraints, _) =>
                        BackgroundImage(),
                    footerBuilder: (context, _) {
                      return Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: TextButton(
                              onPressed: () =>
                                  General.openUrl(docsFolder + "terms.pdf"),
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
                      GoogleProviderConfiguration(
                          clientId:
                              "922511656456-cbo300fdjk9q1t2sk7nil013mpblghv0.apps.googleusercontent.com")
                    ]);
              }
              return AuthGate(loggedUser: snapshot.data as User);
            })
      ]);
}
