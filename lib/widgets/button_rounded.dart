import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key? key,
      required String label,
      required Function onClick,
      IconData? icon,
      Color? color,
      Color? textColor,
      double? sizeMultiplier})
      : _label = label,
        _onClick = onClick,
        _icon = icon,
        _color = color ?? kPrimaryColor,
        _textColor = textColor ?? kBlack,
        _sizeMultiplier = sizeMultiplier,
        super(key: key);

  final String _label;
  final Function _onClick;
  final IconData? _icon;
  final Color _color;
  final Color _textColor;
  final double? _sizeMultiplier;

  @override
  Widget build(BuildContext context) => Container(
      height: MediaQuery.of(context).size.height * (_sizeMultiplier ?? 0.08),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: _color),
      child: TextButton(
          onPressed: () => _onClick(),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (_icon != null) ...[Icon(_icon!, color: _textColor), const SizedBox(width: 10)],
            Text(_label, style: TextStyle(color: _textColor, fontWeight: FontWeight.bold))
          ])));
}
