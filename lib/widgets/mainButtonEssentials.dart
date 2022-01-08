import 'package:flutter/material.dart';
import 'package:letbike/general/pallete.dart';
import 'package:letbike/widgets/buttonCircular.dart';

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

// ignore: must_be_immutable
class MainButtonClicked extends StatefulWidget {
  MainButtonClicked(
      {Key? key,
      required List<SecondaryButtonData> buttons,
      required double volume})
      : _buttons = buttons,
        _volume = volume,
        super(key: key);

  final List<SecondaryButtonData> _buttons;
  double _volume;

  static List<SecondaryButtonPos> positions = [
    SecondaryButtonPos(40, 150),
    SecondaryButtonPos(120, 120),
    SecondaryButtonPos(150, 40),
    SecondaryButtonPos(200, 100)
  ];

  State<StatefulWidget> createState() => MainButtonClickedState();
}

class MainButtonClickedState extends State<MainButtonClicked> {
  @override
  Widget build(BuildContext context) => IgnorePointer(
      ignoring: widget._volume == 0 ? true : false,
      child: Container(
          color: Colors.black.withOpacity(widget._volume),
          child: TextButton(
              onPressed: () => setState(() {
                    widget._volume = 0;
                  }),
              child: Stack(children: [
                for (int i = 0; i < widget._buttons.length; i++)
                  Positioned(
                      bottom: MainButtonClicked.positions[i].x,
                      right: MainButtonClicked.positions[i].y,
                      child: CircularButton(
                          kSecondaryColor.withOpacity(widget._volume * 2),
                          40,
                          widget._buttons[i].icon,
                          kWhite.withOpacity(widget._volume * 2),
                          widget._buttons[i].onClick))
              ]))));
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
