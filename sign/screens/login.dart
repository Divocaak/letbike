import 'package:flutter/material.dart';
import '../../general/widgets.dart';
import '../../general/pallete.dart';
import '../../general/dbServices.dart';
import '../../app/homePage.dart';

Future<User> logResponse;

GlobalKey<FormState> _logformkey = GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(
            image:
                'https://mtbs.cz/media/clanky/63713/titulka/1_Qayron_perex.jpg'),
        Form(
          key: _logformkey,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Flexible(
                  child: Center(
                    child: Text(
                      "Letbike",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextInput(
                      icon: Icons.mail,
                      hint: "E-mail",
                      identificator: "logMail",
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                    ),
                    TextInput(
                        icon: Icons.lock,
                        hint: "Heslo",
                        identificator: "logPass",
                        inputAction: TextInputAction.done,
                        obscure: true),
                    GestureDetector(
                        onTap: () =>
                            Navigator.of(context).pushNamed("ForgotPassword"),
                        child: Text("Zapomenuté heslo", style: kBodyText)),
                    SizedBox(
                      height: 25,
                    ),
                    RoundedButton(
                      buttonName: "Přihlásit se",
                      onClick: () {
                        logResponse = DatabaseServices.loginUser(
                          TextInput.getValue("logMail"),
                          TextInput.getValue("logPass"),
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
                                          "Špatně zadané uživatelské jméno nebo heslo.");
                                    } else {
                                      Text("Probíhá přesměrování");
                                      Future.delayed(Duration.zero, () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                HomePage.routeName,
                                                arguments: snapshot.data);
                                      });
                                    }
                                  }

                                  if (snapshot.hasError) {
                                    return Text(
                                        "Někde se stala chyba, zkuste to prosím později.");
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
      ],
    );
  }
}
