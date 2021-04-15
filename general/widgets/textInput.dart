import 'package:flutter/material.dart';
import '../pallete.dart';

class TextInput extends StatelessWidget {
  const TextInput(
      {Key key,
      @required this.icon,
      @required this.hint,
      @required this.controller,
      this.inputType,
      this.inputAction,
      this.obscure,
      this.validationIdentity})
      : super(key: key);

  final IconData icon;
  final String hint;
  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool obscure;
  final String validationIdentity;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 10 * 5.5,
        width: size.width * 0.8,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: kSecondaryColor,
        ),
        child: Center(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(icon, size: 28, color: kWhite),
              ),
              hintText: hint,
              hintStyle: kTitleTextStyle,
            ),
            obscureText: obscure != null ? obscure : false,
            style: kTitleTextStyle,
            keyboardType: inputType,
            textInputAction: inputAction,
            validator: (String value) {
              if (validationIdentity != "" && validationIdentity != null) {
                if (value.isEmpty) {
                  return "Zadejte " + hint;
                }

                if (validationIdentity == "regMail" ||
                    validationIdentity == "logMail") {
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return "Zadejte platný e-mail";
                  }
                }

                if ((validationIdentity == "regPass" && value.length < 8) ||
                    (validationIdentity == "changePassNew" &&
                        value.length < 8)) {
                  return "Heslo musí obsahovat minimálně 8 znaků";
                }
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
