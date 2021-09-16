import 'package:flutter/material.dart';
import 'package:letbike/general/pallete.dart';

class SignLink {
  static Widget build(String label, TextStyle style, Function onClick) {
    return TextButton(
        onPressed: onClick,
        child: Container(
            child: Text(
              label,
              style: style,
            ),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 1, color: kWhite)))));
  }
}

class SignSwitch extends StatefulWidget {
  SignSwitch(this.value, this.label, {key}) : super(key: key);

  final Widget label;
  bool value;

  @override
  _SignSwitchState createState() => _SignSwitchState();
}

class _SignSwitchState extends State<SignSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.label,
        Switch(
          inactiveTrackColor: kError,
          activeTrackColor: kGreen,
          activeColor: kSecondaryColor,
          inactiveThumbColor: kPrimaryColor,
          value: widget.value,
          onChanged: (value) {
            setState(() {
              widget.value = value;
            });
          },
        ),
      ],
    );
  }
}
