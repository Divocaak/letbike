import 'package:flutter/material.dart';
import 'package:letbike/db/dbSign.dart';
import 'package:letbike/db/remoteSettings.dart';
import 'package:letbike/sign/widgetsSign.dart';
import 'package:letbike/general/pallete.dart';
import 'package:letbike/widgets/textInput.dart';
import 'package:letbike/widgets/buttonRounded.dart';
import 'package:letbike/widgets/images.dart';
import 'package:letbike/widgets/alertBox.dart';
import 'package:url_launcher/url_launcher.dart';

Future<String> response;

class CreateNewAccount extends StatefulWidget {
  @override
  _CreateNewAccountState createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController regMailController = TextEditingController();
  final TextEditingController regPassController = TextEditingController();
  final TextEditingController passConfController = TextEditingController();

  SignSwitch termsSwitch = SignSwitch(
      false,
      SignLink.build(
          "Souhlasím s VOP",
          TextStyle(color: kWhite, fontSize: 17, shadows: [
            Shadow(blurRadius: 10.0, color: kBlack, offset: Offset(5.0, 5.0))
          ]),
          () => openUrl("terms.pdf")));
  SignSwitch dataSwitch = SignSwitch(
      false,
      Text("Souhlasím se zpracováním osobních údajů",
          style: TextStyle(color: kWhite, fontSize: 17, shadows: [
            Shadow(blurRadius: 10.0, color: kBlack, offset: Offset(5.0, 5.0))
          ])));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Stack(alignment: Alignment.center, children: [
              BackgroundImage(),
              SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
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
                        termsSwitch,
                        dataSwitch,
                        RoundedButton(
                            buttonName: "Zaregistrovat",
                            onClick: () {
                              String failResponse = "";
                              if (dataSwitch.value && termsSwitch.value) {
                                if (regMailController.text.contains("@") &&
                                    regMailController.text.contains(".") &&
                                    passConfController.text ==
                                        regPassController.text) {
                                  response = DatabaseSign.registerUser(
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

                              ModalWindow.showModalWindow(
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
                                                  style:
                                                      TextStyle(color: kWhite));
                                            }

                                            if (snapshot.hasError) {
                                              return Text(
                                                  "Někde se stala chyba, zkuste to prosím později",
                                                  style:
                                                      TextStyle(color: kWhite));
                                            }

                                            return Center(
                                                child: Image.asset(
                                                    "assets/load.gif"));
                                          }));
                            }),
                        SignLink.build("Přihlásit se", kSignLinkButton,
                            () => Navigator.of(context).pop())
                      ]))
            ])));
  }

  static void openUrl(String doc) async {
    String url = docsFolder + "/" + doc;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Nelze otevřít.';
    }
  }
}
