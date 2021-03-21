import 'package:flutter/material.dart';
import 'package:profile_app_ui/constants.dart';

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
          color: Theme.of(context).backgroundColor,
        ),
        child: Center(
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(icon, size: 28, color: Colors.white),
              ),
              hintText: hint,
              hintStyle: kTitleTextStyle,
            ),
            style: kTitleTextStyle,
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
          ),
        ),
      ),
    );
  }
}
