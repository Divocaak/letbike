import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../general/general.dart';
import '../app/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets/signWidgets.dart';

Future<User> logResponse;

bool remember = false;
bool savedRemember = false;
String savedEmail = "";
String savedPass = "";

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getLocalData();

    return Scaffold(
        body: Stack(children: [
      BackgroundImage(),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Letbike",
              style: TextStyle(
                color: Colors.white,
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextInput(
            icon: Icons.mail,
            hint: "E-mail",
            inputType: TextInputType.emailAddress,
            inputAction: TextInputAction.next,
            controller: mailController,
          ),
          TextInput(
              icon: Icons.lock,
              hint: "Heslo",
              inputAction: TextInputAction.done,
              obscure: true,
              controller: passController),
          SignLink.build(context, "Zapomenuté heslo", kBodyText,
              () => Navigator.of(context).pushNamed("ForgotPassword")),
          SignSwitch(
              Text(
                "Zapamatovat přihlášení",
                style: TextStyle(color: kWhite, fontSize: 17, shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: kBlack,
                    offset: Offset(5.0, 5.0),
                  ),
                ]),
              ),
              remember,
              kSecondaryColor,
              kPrimaryColor),
          RoundedButton(
              buttonName: "Přihlásit se",
              onClick: () {
                if (remember) {
                  setLocalData(
                      remember, mailController.text, passController.text);
                }

                logResponse = DatabaseServices.loginUser(
                  mailController.text,
                  passController.text,
                );

                AlertBox.showAlertBox(
                    context,
                    "Oznámení",
                    FutureBuilder(
                        future: logResponse,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.id < 0) {
                              return Text(
                                  "Špatně zadané uživatelské jméno nebo heslo.",
                                  style: TextStyle(color: kWhite));
                            } else {
                              Text("Probíhá přesměrování",
                                  style: TextStyle(color: kWhite));
                              Future.delayed(Duration.zero, () {
                                Navigator.of(context).pushReplacementNamed(
                                    HomePage.routeName,
                                    arguments: new HomeArguments(snapshot.data,
                                        ItemParams.createEmpty()));
                              });
                            }
                          }

                          if (snapshot.hasError) {
                            return Text(
                              "Někde se stala chyba, zkuste to prosím později.",
                              style: TextStyle(color: kWhite),
                            );
                          }

                          return Center(child: CircularProgressIndicator());
                        }));
              }),
          SignLink.build(context, "Zaregistrovat se", kBodyText,
              () => Navigator.of(context).pushNamed("CreateNewAccount"))
        ],
      )
    ]));
  }

  getLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    savedRemember = prefs.getBool("savedRemember") ?? false;
    if (savedRemember) {
      remember = savedRemember;
      savedEmail = prefs.getString("savedEmail");
      savedPass = prefs.getString("savedPass");

      mailController.text = savedEmail;
      passController.text = savedPass;
    }
  }

  setLocalData(bool toRem, String toEmail, String toPass) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("savedRemember", toRem);
    prefs.setString("savedEmail", toEmail);
    prefs.setString("savedPass", toPass);
  }

  deleteLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('savedRemember');
    prefs.remove('savedEmail');
    prefs.remove('savedPass');
  }
}
