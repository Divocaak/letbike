import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/widgets/new/button_circular.dart';

class MainButtonSub extends StatelessWidget {
  const MainButtonSub(
      {Key? key,
      required IconData icon,
      required String label,
      required onClick})
      : _icon = icon,
        _label = label,
        _onClick = onClick,
        super(key: key);

  final IconData _icon;
  final String _label;
  final Function _onClick;

  @override
  Widget build(BuildContext context) => Container(
      height: kButtonCircleSmall * 1.5,
      padding: EdgeInsets.only(bottom: 20),
      child: Stack(children: [
        Positioned(
            right: kButtonCircleSmall * .7,
            top: kButtonCircleSmall * .1,
            child: Container(
                decoration: BoxDecoration(
                    color: kSecondaryColor,
                    border: Border.all(color: kSecondaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(_label, style: TextStyle(color: kWhite)))),
        Positioned(
            right: 0, child: CircularButton(icon: _icon, onClick: _onClick))
      ]));
}
