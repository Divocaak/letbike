import 'package:flutter/material.dart';
import 'package:letbike/settings.dart';

class AccountInfoField extends StatelessWidget {
  const AccountInfoField({Key? key, required String text})
      : _text = text,
        super(key: key);

  final String _text;

  @override
  Widget build(BuildContext context) {
    int divider = _text.indexOf(":", 0) + 1;
    String value = _text.substring(divider, _text.length);
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: _text.substring(0, divider),
                  style: TextStyle(color: kWhite)),
              TextSpan(
                  text: (value != " -1" ? value : " ???"),
                  style: TextStyle(fontWeight: FontWeight.bold, color: kWhite))
            ])));
  }
}
