import 'package:flutter/material.dart';
import '../../general/pallete.dart';

String _email, _name;

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key key,
    @required this.icon,
    @required this.hint,
    this.inputType,
    this.inputAction,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;

  static String getValue(String hint) {
    if (hint == "Name") {
      return _name;
    } else if (hint == "Email") {
      return _email;
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
            style: kBodyText,
            keyboardType: inputType,
            textInputAction: inputAction,
            validator: (String value) {
              if (value.isEmpty) {
                return "Please enter " + hint;
              }
              if (hint == "Email") {
                if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                    .hasMatch(value)) {
                  return "Please enter a valid Email";
                }
              }
              return null;
            },
            onChanged: (String content) {
              if (hint == "Name") {
                _name = content;
              }
              if (hint == "Email") {
                _email = content;
              }
            },
          ),
        ),
      ),
    );
  }
}
