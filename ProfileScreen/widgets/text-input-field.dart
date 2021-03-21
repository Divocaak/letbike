import 'package:flutter/material.dart';
<<<<<<< HEAD:sign/widgets/signTextInputField.dart
import '../../general/pallete.dart';

String _email, _name;
=======
import 'package:profile_app_ui/constants.dart';
>>>>>>> skupina-a:ProfileScreen/widgets/text-input-field.dart

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

<<<<<<< HEAD:sign/widgets/signTextInputField.dart
  static String getValue(String hint) {
    if (hint == "Name") {
      return _name;
    } else if (hint == "Email") {
      return _email;
    } else {
      return "";
    }
  }

=======
>>>>>>> skupina-a:ProfileScreen/widgets/text-input-field.dart
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
<<<<<<< HEAD:sign/widgets/signTextInputField.dart
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[500].withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
=======
        height: 10 * 5.5,
        width: size.width * 0.8,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).backgroundColor,
>>>>>>> skupina-a:ProfileScreen/widgets/text-input-field.dart
        ),
        child: Center(
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
<<<<<<< HEAD:sign/widgets/signTextInputField.dart
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
=======
                child: Icon(icon, size: 28, color: Colors.white),
              ),
              hintText: hint,
              hintStyle: kTitleTextStyle,
            ),
            style: kTitleTextStyle,
>>>>>>> skupina-a:ProfileScreen/widgets/text-input-field.dart
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
<<<<<<< HEAD:sign/widgets/signTextInputField.dart
            onChanged: (String content) {
              if (hint == "Name") {
                _name = content;
              }
              if (hint == "Email") {
                _email = content;
              }
            },
=======
>>>>>>> skupina-a:ProfileScreen/widgets/text-input-field.dart
          ),
        ),
      ),
    );
  }
}
