import 'package:flutter/material.dart';
import '../../general/pallete.dart';

String _pass, _confPass;

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

  static String getValue(String hint) {
    if (hint == "Password") {
      return _pass;
    } else if (hint == "Confirm Password") {
      return _confPass;
    } else {
      return "";
    }
  }

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
              if (_pass != _confPass) {
                return "Passwords are not equal";
              }
              return null;
            },
            onChanged: (String content) {
              if (hint == "Password") {
                _pass = content;
              }
              if (hint == "Confirm Password") {
                _confPass = content;
              }
            },
          ),
        ),
      ),
    );
  }
}
