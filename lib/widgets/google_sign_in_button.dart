import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letbike/general/authentification.dart';
import 'package:letbike/screens/auth_screen.dart';
import 'package:letbike/widgets/button_rounded.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) => _isSigningIn
      ? CircularProgressIndicator()
      : RoundedButton(
          onClick: () async {
            setState(() => _isSigningIn = true);

            User? user =
                await Authentication.signInWithGoogle(context: context);

            setState(() => _isSigningIn = false);

            if (user != null) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => AuthGate(loggedUser: user)));
            }
          },
          buttonName: "Přihlásit s Google");
}
