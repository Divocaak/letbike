import 'package:flutter/material.dart';
import '../general/widgets.dart';
import '../general/general.dart';
import 'widgets/signWidgets.dart';

class ForgotPassword extends StatelessWidget {
  final TextEditingController forgotMailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(alignment: Alignment.center, children: [
          BackgroundImage(),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextInput(
                icon: Icons.mail,
                hint: "Email",
                inputType: TextInputType.emailAddress,
                inputAction: TextInputAction.done,
                controller: forgotMailController),
            RoundedButton(buttonName: "Send", onClick: () {}),
            SignLink.build(context, "Přihlásit se", kSignLinkButton,
                () => Navigator.of(context).pop()),
          ])
        ]));
  }
}
