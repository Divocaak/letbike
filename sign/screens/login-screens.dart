import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:letbike/sign/alertBox.dart';
import '../../general/pallete.dart';
import '../../general/dbServices.dart';
import '../widgets.dart';
import '../../app/homePage.dart';

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
                    TextInputField(
                      icon: FontAwesomeIcons.envelope,
                      hint: "Email",
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                    ),
                    PasswordInput(
                      icon: FontAwesomeIcons.lock,
                      hint: "Password",
                      inputAction: TextInputAction.done,
                    ),
                    GestureDetector(
                        onTap: () =>
                            Navigator.of(context).pushNamed("ForgotPassword"),
                        child: Text("Forgot Password", style: kBodyText)),
                    SizedBox(
                      height: 25,
                    ),
                    LogRoundedButton(
                      buttonName: "Login",
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
                      "Create New Account",
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

Future<User> logResponse;

class LogRoundedButton extends StatelessWidget {
  const LogRoundedButton({
    Key key,
    @required this.buttonName,
  }) : super(key: key);

  final String buttonName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.green),
      child: TextButton(
        onPressed: () {
          logResponse = DatabaseServices.loginUser(
            TextInputField.getValue("Email"),
            PasswordInput.getValue("Password"),
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
                          Navigator.of(context).pushReplacementNamed(
                              HomePage.routeName,
                              arguments: snapshot.data);
                        });
                      }
                    }

                    if (snapshot.hasError) {
                      return Text(
                          "Někde se stala chyba, zkuste to prosím později.");
                    }

                    return Center(child: CircularProgressIndicator());
                  }));
        },
        child: Text(
          buttonName,
          style: kBodyText.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
