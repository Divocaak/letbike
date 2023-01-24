import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/widgets/new/button_circular.dart';

// ignore: must_be_immutable
class MainButtonClicked extends StatefulWidget {
  MainButtonClicked({Key? key, required List<SecondaryButtonData> buttons, required double volume})
      : _buttons = buttons,
        _volume = volume,
        super(key: key);

  final List<SecondaryButtonData> _buttons;
  double _volume;

  static List<Map<String, double>> positions = [
    {"x": 40, "y": 150},
    {"x": 120, "y": 120},
    {"x": 150, "y": 40},
    {"x": 200, "y": 100}
  ];

  @override
  State<StatefulWidget> createState() => MainButtonClickedState();
}

class MainButtonClickedState extends State<MainButtonClicked> {
  @override
  Widget build(BuildContext context) => IgnorePointer(
      ignoring: widget._volume == 0 ? true : false,
      child: Container(
          color: Colors.black.withOpacity(widget._volume),
          child: TextButton(
              onPressed: () => setState(() => widget._volume = 0),
              child: Stack(children: [
                for (int i = 0; i < widget._buttons.length; i++)
                  Positioned(
                      bottom: MainButtonClicked.positions[i]["x"],
                      right: MainButtonClicked.positions[i]["y"],
                      child: CircularButton(
                          color: kSecondaryColor.withOpacity(widget._volume * 2),
                          icon: widget._buttons[i].icon,
                          iconColor: kWhite.withOpacity(widget._volume * 2),
                          onClick: widget._buttons[i].onClick))
              ]))));
}

class SecondaryButtonData {
  IconData icon;
  Function onClick;

  SecondaryButtonData(this.icon, this.onClick);
}
