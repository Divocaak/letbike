import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key? key,
      required String buttonName,
      required Function onClick,
      Color? color,
      double? sizeMultiplier})
      : _buttonName = buttonName,
        _onClick = onClick,
        _color = color,
        _sizeMultiplier = sizeMultiplier,
        super(key: key);

  final String _buttonName;
  final Function _onClick;
  final Color? _color;
  final double? _sizeMultiplier;

  @override
  Widget build(BuildContext context) => Container(
      height: MediaQuery.of(context).size.height * (_sizeMultiplier ?? 0.08),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _color ?? kPrimaryColor),
      child: TextButton(
          onPressed: () => _onClick(),
          child: Text(_buttonName,
              style: kMainButtonStyle.copyWith(fontWeight: FontWeight.bold))));
}
