import 'package:flutter/material.dart';
import 'package:letbike/general/pallete.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/db/dbAccount.dart';
import 'package:letbike/widgets/textInput.dart';
import 'package:letbike/widgets/mainButtonEssentials.dart';
import 'package:letbike/widgets/errorWidgets.dart';
import 'package:letbike/widgets/alertBox.dart';

double volume = 0;

GlobalKey<FormState> _changePassKey = GlobalKey<FormState>();

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
  static const routeName = "/changePass";
}

Future<String> changeResponse;

class _ChangePasswordState extends State<ChangePassword>
    with SingleTickerProviderStateMixin {
  User user;
  AnimationController animationController;

  final TextEditingController currController = TextEditingController();
  final TextEditingController newController = TextEditingController();
  final TextEditingController confController = TextEditingController();

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    animationController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context).settings.arguments;

    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: kBlack,
            floatingActionButton: MainButton(
                iconData: Icons.menu,
                onPressed: () {
                  if (animationController.isCompleted) {
                    animationController.reverse();
                    volume = 0;
                  } else {
                    animationController.forward();
                    volume = 0.5;
                  }
                }),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            body: Stack(alignment: Alignment.center, children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextInput(
                    icon: Icons.lock,
                    hint: "Aktuální heslo",
                    obscure: true,
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    controller: currController),
                TextInput(
                  icon: Icons.lock,
                  hint: "Nové heslo",
                  obscure: true,
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  validationIdentity: "changePassNew",
                  controller: newController,
                ),
                TextInput(
                  icon: Icons.lock,
                  hint: "Nové heslo znovu",
                  obscure: true,
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  validationIdentity: "changePassConf",
                  controller: confController,
                )
              ]),
              MainButtonClicked(buttons: [
                SecondaryButtonData(
                    Icons.arrow_back, () => Navigator.of(context).pop()),
                SecondaryButtonData(Icons.save, () {
                  String failResponse = "";

                  if (_changePassKey.currentState.validate() &&
                      newController.text == confController.text) {
                    changeResponse = DatabaseAccount.changePassword(
                        user.id.toString(),
                        newController.text,
                        currController.text);
                  } else {
                    failResponse =
                        "Některé údaje jsou špatně zadané, nebo se hesla neshodují";
                  }

                  ModalWindow.showModalWindow(
                      context,
                      "Oznámení",
                      failResponse != ""
                          ? new Text(failResponse)
                          : FutureBuilder<String>(
                              future: changeResponse,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(snapshot.data,
                                      style: TextStyle(color: kWhite));
                                } else if (snapshot.hasError) {
                                  return ErrorWidgets.futureBuilderError();
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                            ));

                  Navigator.of(context).pop();
                })
              ], volume: volume)
            ])));
  }
}
