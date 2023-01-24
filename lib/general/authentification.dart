import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:letbike/screens/auth_screen.dart';
import 'package:letbike/screens/sign_in_screen.dart';

class Authentication {
  static Future<FirebaseApp> initializeFirebase({required BuildContext context}) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthGate(loggedUser: user)));
    }

    return firebaseApp;
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential = await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
              Authentication.customSnackBar(content: 'The account already exists with a different credential.'));
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
              Authentication.customSnackBar(content: 'Error occurred while accessing credentials. Try again.'));
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(Authentication.customSnackBar(content: 'Error occurred using Google Sign-In. Try again.'));
      }
    }

    return user;
  }

  static Future<void> signOut({required BuildContext context}) async {
    try {
      await GoogleSignIn().disconnect().whenComplete(() async => await FirebaseAuth.instance.signOut().then((value) =>
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignInScreen()))));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(Authentication.customSnackBar(content: 'Error signing out. Try again.'));
    }
  }

  static SnackBar customSnackBar({required String content}) => SnackBar(
      backgroundColor: Colors.black,
      content: Text(content, style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5)));
}
