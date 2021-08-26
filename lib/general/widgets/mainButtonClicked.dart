import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../pallete.dart';

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
    //MediaQuery.of(context).size;
    return Stack(
      children: [
        for (int i = 0; i < buttons.length; i++)
          Positioned(
              bottom: positions[i].x,
              right: positions[i].y,
              child: Container(
                decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(volume * 2),
                    shape: BoxShape.circle),
                width: 40,
                height: 40,
                child: IconButton(
                  icon: Icon(buttons[i].icon,
                      color: kWhite.withOpacity(volume * 2)),
                  enableFeedback: true,
                  onPressed: buttons[i].onClick,
                ),
              )),
      ],
    );
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
