import 'package:flutter/material.dart';
import '../../general/general.dart';
import '../../app/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<User> logResponse;

bool remember = false;
bool savedRemember = false;
String savedEmail = "";
String savedPass = "";

GlobalKey<FormState> _logformkey = GlobalKey<FormState>();

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

    return Stack(
      children: [
        BackgroundImage(),
        Form(
          key: _logformkey,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 125,
                  ),
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
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
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
                      GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed("ForgotPassword"),
                          child: Text("Zapomenuté heslo", style: kBodyText)),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        padding: EdgeInsetsDirectional.only(start: 100),
                        child: Row(
                          children: [
                            Text(
                              "Zapamatovat přihlášení",
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
                              value: remember,
                              onChanged: (value) {
                                setState(() {
                                  remember = value;
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
                        buttonName: "Přihlásit se",
                        onClick: () {
                          if (remember) {
                            setLocalData(remember, mailController.text,
                                passController.text);
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
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  HomePage.routeName,
                                                  arguments: new HomeArguments(
                                                      snapshot.data,
                                                      ItemParams
                                                          .createEmpty()));
                                        });
                                      }
                                    }

                                    if (snapshot.hasError) {
                                      return Text(
                                        "Někde se stala chyba, zkuste to prosím později.",
                                        style: TextStyle(color: kWhite),
                                      );
                                    }

                                    return Center(
                                        child: CircularProgressIndicator());
                                  }));
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed("CreateNewAccount"),
                    child: Container(
                      child: Text(
                        "Zaregistrovat se",
                        style: kBodyText,
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 1, color: kWhite))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
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
