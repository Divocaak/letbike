import 'package:flutter/material.dart';
import 'package:letbike/general/pallete.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key? key, required String buttonName, required Function onClick})
      : _buttonName = buttonName,
        _onClick = onClick,
        super(key: key);

  final String _buttonName;
  final Function _onClick;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: kPrimaryColor),
        child: TextButton(
            onPressed: () => _onClick(),
            child: Text(_buttonName,
                style:
                    kMainButtonStyle.copyWith(fontWeight: FontWeight.bold))));
  }
}
