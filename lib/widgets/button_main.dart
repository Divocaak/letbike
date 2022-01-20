import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';

class MainButton extends StatelessWidget {
  MainButton(
      {Key? key, required IconData iconData, required Function onPressed})
      : _iconData = iconData,
        _onPressed = onPressed,
        super(key: key);

  final IconData _iconData;
  final Function _onPressed;

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.only(bottom: 35, right: 35),
      child: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          child: Icon(_iconData, color: kWhite),
          onPressed: () => _onPressed()));
}
