import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/widgets/button_circular.dart';

class MainButton extends StatelessWidget {
  MainButton(
      {Key? key,
      required IconData iconData,
      required Function onPressed,
      bool? showButtons})
      : _iconData = iconData,
        _onPressed = onPressed,
        _showButtons = showButtons!,
        super(key: key);

  final IconData _iconData;
  final Function _onPressed;
  final bool _showButtons;

  @override
  Widget build(BuildContext context) => IgnorePointer(
      ignoring: false,
      child: Container(
          color: Colors.black.withOpacity(0.7),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              verticalDirection: VerticalDirection.up,
              children: [
                CircularButton(icon: _iconData, onClick: () => _onPressed()),
                if (_showButtons) ...[
                  CircularButton(icon: Icons.textsms_sharp, onClick: () {}),
                  CircularButton(icon: Icons.textsms_sharp, onClick: () {}),
                  CircularButton(icon: Icons.textsms_sharp, onClick: () {})
                ]
              ])));
}
