import 'package:flutter/material.dart';
import 'package:letbike/general/general.dart';
import 'package:letbike/general/pallete.dart';
import 'package:letbike/widgets/buttonCircular.dart';

class MainButton extends StatelessWidget {
  MainButton({Key key, @required this.iconData, @required this.onPressed})
      : super(key: key);

  final IconData iconData;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 35, right: 35),
        child: FloatingActionButton(
            backgroundColor: kPrimaryColor,
            child: Icon(iconData, color: kWhite),
            onPressed: onPressed));
  }
}

class MainButtonClicked extends StatelessWidget {
  const MainButtonClicked(
      {Key key, @required this.buttons, @required this.volume})
      : super(key: key);

  final List<SecondaryButtonData> buttons;
  final double volume;

  static List<SecondaryButtonPos> positions = [
    SecondaryButtonPos(40, 150),
    SecondaryButtonPos(120, 120),
    SecondaryButtonPos(150, 40),
    SecondaryButtonPos(200, 100)
  ];

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
        ignoring: volume == 0 ? true : false,
        child: Container(
            color: Colors.black.withOpacity(volume),
            child: Stack(
              children: [
                for (int i = 0; i < buttons.length; i++)
                  Positioned(
                      bottom: positions[i].x,
                      right: positions[i].y,
                      child: CircularButton(
                          kSecondaryColor.withOpacity(volume * 2),
                          40,
                          buttons[i].icon,
                          kWhite.withOpacity(volume * 2),
                          buttons[i].onClick)),
              ],
            )));
  }
}

class SecondaryButtonData {
  IconData icon;
  Function onClick;

  SecondaryButtonData(this.icon, this.onClick);
}

class SecondaryButtonPos {
  double x;
  double y;

  SecondaryButtonPos(this.x, this.y);
}
