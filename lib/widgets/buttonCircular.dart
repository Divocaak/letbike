import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final Color color;
  final double size;
  final IconData icon;
  final Color iconColor;
  final Function onClick;

  CircularButton(
      this.color, this.size, this.icon, this.iconColor, this.onClick);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: size,
      height: size,
      child: IconButton(
        icon: Icon(icon, color: iconColor),
        enableFeedback: true,
        onPressed: onClick,
      ),
    );
  }
}
