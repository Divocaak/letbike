import 'package:flutter/material.dart';
import 'package:letbike/settings.dart';

class CircularButton extends StatelessWidget {
  const CircularButton(
      {Key? key,
      required IconData icon,
      required Function onClick,
      Color? color,
      double? size,
      Color? iconColor})
      : _icon = icon,
        _onClick = onClick,
        _color = color ?? kSecondaryColor,
        _size = size ?? 40,
        _iconColor = iconColor ?? kWhite,
        super(key: key);

  final IconData _icon;
  final Function _onClick;
  final Color _color;
  final double _size;
  final Color _iconColor;

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(color: _color, shape: BoxShape.circle),
      width: _size,
      height: _size,
      child: IconButton(
          icon: Icon(_icon, color: _iconColor),
          enableFeedback: true,
          onPressed: () => _onClick()));
}
