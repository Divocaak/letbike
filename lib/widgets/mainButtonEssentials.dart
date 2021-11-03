import 'package:flutter/material.dart';
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

class MainButtonClicked extends StatefulWidget {
  MainButtonClicked({Key key, @required this.buttons, @required this.volume})
      : super(key: key);

  final List<SecondaryButtonData> buttons;
  double volume;

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
  Widget build(BuildContext context) {
    return IgnorePointer(
        ignoring: widget.volume == 0 ? true : false,
        child: Container(
            color: Colors.black.withOpacity(widget.volume),
            child: TextButton(
                onPressed: () => setState(() {
                      widget.volume = 0;
                    }),
                child: Stack(children: [
                  for (int i = 0; i < widget.buttons.length; i++)
                    Positioned(
                        bottom: MainButtonClicked.positions[i].x,
                        right: MainButtonClicked.positions[i].y,
                        child: CircularButton(
                            kSecondaryColor.withOpacity(widget.volume * 2),
                            40,
                            widget.buttons[i].icon,
                            kWhite.withOpacity(widget.volume * 2),
                            widget.buttons[i].onClick))
                ]))));
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
