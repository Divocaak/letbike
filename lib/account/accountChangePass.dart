import 'dart:ui';
import 'package:flutter/material.dart';
import '../general/general.dart';

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

    return new Scaffold(
      body: Stack(children: [
        Scaffold(
          backgroundColor: kBlack,
          body: SingleChildScrollView(
            child: Form(
              key: _changePassKey,
              child: Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Column(
                    children: [
                      TextInput(
                          icon: Icons.lock,
                          hint: "Aktuální heslo",
                          obscure: true,
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.next,
                          controller: currController),
                      SizedBox(
                        height: 25,
                      ),
                      TextInput(
                        icon: Icons.lock,
                        hint: "Nové heslo",
                        obscure: true,
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        validationIdentity: "changePassNew",
                        controller: newController,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextInput(
                        icon: Icons.lock,
                        hint: "Nové heslo znovu",
                        obscure: true,
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        validationIdentity: "changePassConf",
                        controller: confController,
                      ),
                    ],
                  )
                ],
              )),
            ),
          ),
        ),
        IgnorePointer(
          ignoring: volume == 0 ? true : false,
          child: Container(
            color: Colors.black.withOpacity(volume),
            child: Stack(
              children: [
                Positioned(
                    bottom: 120,
                    right: 120,
                    child: CircularButton(
                        kSecondaryColor.withOpacity(volume * 2),
                        45,
                        Icons.arrow_back,
                        kWhite.withOpacity(volume * 2), () {
                      Navigator.of(context).pop();
                    })),
                Positioned(
                    bottom: 150,
                    right: 40,
                    child: CircularButton(
                        kSecondaryColor.withOpacity(volume * 2),
                        45,
                        Icons.save,
                        kWhite.withOpacity(volume * 2), () {
                      String failResponse = "";

                      if (_changePassKey.currentState.validate() &&
                          newController.text == confController.text) {
                        changeResponse = DatabaseServices.changePassword(
                            user.id.toString(),
                            newController.text,
                            currController.text);
                      } else {
                        failResponse =
                            "Některé údaje jsou špatně zadané, nebo se hesla neshodují";
                      }

                      AlertBox.showAlertBox(
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
                                      return Text('Sorry there is an error',
                                          style: TextStyle(color: kWhite));
                                    }
                                    return Center(
                                        child: CircularProgressIndicator());
                                  },
                                ));
                    })),
              ],
            ),
          ),
        ),
        Positioned(
            height: 275,
            width: 275,
            right: -75,
            bottom: -75,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CircularButton(kPrimaryColor, 60, Icons.menu, kWhite, () {
                  if (animationController.isCompleted) {
                    animationController.reverse();
                    volume = 0;
                  } else {
                    animationController.forward();
                    volume = 0.5;
                  }
                })
              ],
            ))
      ]),
    );
  }
}
