import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:letbike/general/settings.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:letbike/user/authGate.dart';
import 'package:letbike/widgets/images.dart';

class SignGate extends StatelessWidget {
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
                      GoogleProviderConfiguration(clientId: "clientId")
                    ]);
              }

              return AuthGate(loggedUser: snapshot.data as User);
            })
      ]);
}
