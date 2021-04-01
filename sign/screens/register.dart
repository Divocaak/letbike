import 'dart:ui';
import 'package:flutter/material.dart';
import '../../general/pallete.dart';
import '../../general/dbServices.dart';
import '../../general/widgets.dart';

Future<String> response;

GlobalKey<FormState> _regformkey = GlobalKey<FormState>();

class CreateNewAccount extends StatefulWidget {
  @override
  _CreateNewAccountState createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
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
                        identificator: "regName",
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next,
                      ),
                      TextInput(
                        icon: Icons.mail,
                        hint: "E-mail",
                        identificator: "regMail",
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                      ),
                      TextInput(
                          icon: Icons.lock,
                          hint: "Heslo",
                          identificator: "regPass",
                          inputAction: TextInputAction.next,
                          obscure: true),
                      TextInput(
                          icon: Icons.lock,
                          hint: "Potvrdit heslo",
                          identificator: "regPassConf",
                          inputAction: TextInputAction.done,
                          obscure: true),
                      SizedBox(
                        height: 25,
                      ),
                      RoundedButton(
                        buttonName: "Registrovat",
                        onClick: () {
                          String failResponse = "";

                          if (_regformkey.currentState.validate()) {
                            response = DatabaseServices.registerUser(
                                TextInput.getValue("regName"),
                                TextInput.getValue("regMail"),
                                TextInput.getValue("regPass"));
                          } else {
                            failResponse = "Některé údaje jsou špatně zadané.";
                          }

                          AlertBox.showAlertBox(
                              context,
                              "Oznámení",
                              failResponse != ""
                                  ? new Text(failResponse)
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
}
