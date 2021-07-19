import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:letbike/general/general.dart';
import '../../general/pallete.dart';
import '../../general/dbServices.dart';
import '../../general/widgets.dart';
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
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        BackgroundImage(),
        Form(
          key: _regformkey,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Column(
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
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsetsDirectional.only(start: 20),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                openUrl("terms.pdf");
                              },
                              child: Text(
                                "Souhlasím s Všebecné obchodní podmínky",
                                style: TextStyle(
                                    color: kWhite,
                                    fontSize: 17,
                                    decoration: TextDecoration.underline,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10.0,
                                        color: kBlack,
                                        offset: Offset(5.0, 5.0),
                                      ),
                                    ]),
                              ),
                            ),
                            Switch(
                              value: acceptTerms,
                              onChanged: (value) {
                                setState(() {
                                  acceptTerms = value;
                                });
                              },
                              inactiveTrackColor: kSecondaryColor,
                              activeTrackColor: kPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsetsDirectional.only(start: 20),
                        child: Row(
                          children: [
                            Text(
                              "Souhlasím se zpracováním osobních údajů",
                              style: TextStyle(
                                  color: kWhite,
                                  fontSize: 17,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: kBlack,
                                      offset: Offset(5.0, 5.0),
                                    ),
                                  ]),
                            ),
                            Switch(
                              value: acceptData,
                              onChanged: (value) {
                                setState(() {
                                  acceptData = value;
                                });
                              },
                              inactiveTrackColor: kSecondaryColor,
                              activeTrackColor: kPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      RoundedButton(
                        buttonName: "Registrovat",
                        onClick: () {
                          String failResponse = "";

                          if (acceptData && acceptTerms) {
                            if (_regformkey.currentState.validate() &&
                                passConfController.text ==
                                    regPassController.text) {
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
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Už máte účet?  ", style: kBodyText),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Přihlaste se",
                              style: kBodyText.copyWith(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
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
