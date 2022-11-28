import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letbike/remote/params.dart';
import 'package:letbike/screens/home_screen.dart';
import 'package:letbike/remote/users.dart';
import 'package:letbike/widgets/image_background.dart';

class AuthGate extends StatefulWidget {
  AuthGate({Key? key, required User loggedUser})
      : _loggedUser = loggedUser,
        super(key: key);

  final User _loggedUser;

  @override
  _AuthGateState createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  // NOTE wtf??
  final TextStyle textStyle =
      TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold);
  late BackgroundImage bgImage;

  @override
  void initState() {
    bgImage = BackgroundImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Stack(alignment: Alignment.center, children: [
        bgImage,
        FutureBuilder(
            future: Future.wait({
              RemoteUser.checkUserStatus(
                  widget._loggedUser.uid,
                  widget._loggedUser.displayName ?? "jméno",
                  widget._loggedUser.email ?? "email"),
              RemoteParams.getParams()
            }),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data![0] == 1) {
                  return HomePage(
                      loggedUser: widget._loggedUser,
                      params: snapshot.data![1]);
                } else {
                  return Text("Jste zabanován, kontaktujte prosím podporu",
                      style: textStyle);
                }
              }

              if (snapshot.hasError) {
                print(snapshot.error);
                return Text(
                    "Někde se stala chyba, zkuste to prosím později (0)",
                    style: textStyle);
              }
              return Center(child: Image.asset("assets/load.gif"));
            })
      ]));
}
