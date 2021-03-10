import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login/pallete.dart';
import 'package:login/widgets/widgets.dart';

GlobalKey<FormState> _regformkey = GlobalKey<FormState>();
TextEditingController _password = TextEditingController();
TextEditingController _confirmpassword = TextEditingController();

class CreateNewAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(
            image:
                'https://mtbs.cz/media/clanky/63713/titulka/1_Qayron_perex.jpg'),
        Form(
          key: _regformkey,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.width * 0.2,
                  ),
                  Stack(
                    children: [
                      Center(
                        child: ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                            child: CircleAvatar(
                              // backgroundImage: NetworkImage(
                              //     "https://c1.primacdn.cz/sites/default/files/styles/landscape_extra_large/public/695f022f/3671101-ct_18.jpg?itok=AEHAQKRs&c=def_cloudinary"),
                              radius: size.width * 0.14,
                              backgroundColor:
                                  Colors.grey[400].withOpacity(0.5),
                              child: Icon(FontAwesomeIcons.user,
                                  color: kWhite, size: size.width * 0.1),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.08,
                        left: size.width * 0.56,
                        child: Container(
                          height: size.width * 0.08,
                          width: size.width * 0.08,
                          decoration: BoxDecoration(
                            color: kGreen,
                            shape: BoxShape.circle,
                            border: Border.all(color: kWhite, width: 2),
                          ),
                          //child: Icon(FontAwesomeIcons.arrowUp, color: kWhite,),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Column(
                    children: [
                      TextInputField(
                        icon: FontAwesomeIcons.user,
                        hint: "Name",
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next,
                      ),
                      TextInputField(
                        icon: FontAwesomeIcons.envelope,
                        hint: "Email",
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                      ),
                      RegPasswordInput(
                        icon: FontAwesomeIcons.lock,
                        hint: "Password",
                        inputAction: TextInputAction.next,
                        controller: _password,
                      ),
                      RegPasswordInput(
                        icon: FontAwesomeIcons.lock,
                        hint: "Confirm Password",
                        inputAction: TextInputAction.done,
                        controller: _confirmpassword,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      RegRoundedButton(buttonName: "Register"),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Aleready have an account?", style: kBodyText),
                          GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(context, "/");
                            },
                              
                            
                            child: Text(
                              "Login",
                              style: kBodyText.copyWith(
                                  color: kGreen, fontWeight: FontWeight.bold),
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

class RegRoundedButton extends StatelessWidget {
  const RegRoundedButton({
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
      child: FlatButton(
        onPressed: () {
          if (_regformkey.currentState.validate()) {
            return;
          } else {
            print("Unsuccesfull");
          }
        },
        child: Text(
          buttonName,
          style: kBodyText.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class RegPasswordInput extends StatelessWidget {
  const RegPasswordInput({
    Key key,
    @required this.icon,
    @required this.hint,
    this.controller,
    this.inputType,
    this.inputAction,
  }) : super(key: key);

  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[500].withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  icon,
                  size: 28,
                  color: kWhite,
                ),
              ),
              hintText: hint,
              hintStyle: kBodyText,
            ),
            obscureText: false,
            style: kBodyText,
            keyboardType: inputType,
            textInputAction: inputAction,
            controller: controller,
            validator: (String value) {
              if (value.isEmpty) {
                return "Please enter Password";
              }
              if (value.length < 8) {
                return "Password is too short";
              }
              if (_password != _confirmpassword) {
                return "Passwords are not equal";
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
