import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:letbike/general/general.dart';
import 'package:letbike/sign/widgets/signLink.dart';
import 'package:letbike/sign/widgets/signSwitch.dart';
import '../general/pallete.dart';
import '../general/dbServices.dart';
import '../general/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

Future<String> response;

bool acceptData = false;
bool acceptTerms = false;

GlobalKey<FormState> _regformkey = GlobalKey<FormState>();

class CreateNewAccount extends StatefulWidget {
  @override
  _CreateNewAccountState createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController regMailController = TextEditingController();
  final TextEditingController regPassController = TextEditingController();
  final TextEditingController passConfController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundImage(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextInput(
                  icon: Icons.person,
                  hint: "Uživatelské jméno",
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.next,
                  controller: usernameController),
              TextInput(
                  icon: Icons.mail,
                  hint: "E-mail",
                  inputType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next,
                  controller: regMailController),
              TextInput(
                  icon: Icons.lock,
                  hint: "Heslo",
                  inputAction: TextInputAction.next,
                  obscure: true,
                  validationIdentity: "regPass",
                  controller: regPassController),
              TextInput(
                  icon: Icons.lock,
                  hint: "Potvrdit heslo",
                  inputAction: TextInputAction.done,
                  obscure: true,
                  validationIdentity: "regPassConf",
                  controller: passConfController),
              SignSwitch(
                  SignLink.build(
                      context,
                      "Souhlasím s VOP",
                      TextStyle(color: kWhite, fontSize: 17, shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: kBlack,
                          offset: Offset(5.0, 5.0),
                        ),
                      ]),
                      () => openUrl("terms.pdf")),
                  acceptData,
                  kSecondaryColor,
                  kPrimaryColor),
              SignSwitch(
                  Text(
                    "Souhlasím se zpracováním osobních údajů",
                    style: TextStyle(color: kWhite, fontSize: 17, shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: kBlack,
                        offset: Offset(5.0, 5.0),
                      ),
                    ]),
                  ),
                  acceptData,
                  kSecondaryColor,
                  kPrimaryColor),
              RoundedButton(
                buttonName: "Zaregistrovat",
                onClick: () {
                  String failResponse = "";

                  if (acceptData && acceptTerms) {
                    if (_regformkey.currentState.validate() &&
                        passConfController.text == regPassController.text) {
                      response = DatabaseServices.registerUser(
                          usernameController.text,
                          regMailController.text,
                          regPassController.text);
                    } else {
                      failResponse =
                          "Některé údaje jsou špatně zadané, nebo se hesla neshodují";
                    }
                  } else {
                    failResponse =
                        "Pro pokračování musíte souhlasit s VOP a zpracováním osobních údajů.";
                  }

                  AlertBox.showAlertBox(
                      context,
                      "Oznámení",
                      failResponse != ""
                          ? new Text(failResponse,
                              style: TextStyle(color: kWhite))
                          : FutureBuilder(
                              future: response,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(snapshot.data,
                                      style: TextStyle(color: kWhite));
                                }

                                if (snapshot.hasError) {
                                  return Text(
                                      "Někde se stala chyba, zkuste to prosím později",
                                      style: TextStyle(color: kWhite));
                                }

                                return Center(
                                    child: CircularProgressIndicator());
                              }));
                },
              ),
              SignLink.build(context, "Přihlásit se", kSignLinkButton,
                  () => Navigator.of(context).pop())
            ],
          )
        ],
      ),
    );
  }

  openUrl(String doc) async {
    String url = docsFolder + "/" + doc;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Nelze otevřít.';
    }
  }
}
