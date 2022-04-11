import 'package:flutter/material.dart';
import 'package:letbike/settings.dart';

class CardText extends StatelessWidget {
  const CardText(
      {Key? key,
      required String text,
      required double fontSize,
      double? offset,
      FontWeight? fontWeight})
      : _text = text,
        _fontSize = fontSize,
        _offset = offset ?? 1,
        _fontWeight = fontWeight ?? FontWeight.normal,
        super(key: key);

  final String _text;
  final double _fontSize;
  final double _offset;
  final FontWeight _fontWeight;

  @override
  Widget build(BuildContext context) => FittedBox(
      child: Text(_text,
          style: TextStyle(
              fontWeight: _fontWeight,
              color: kWhite,
              fontSize: _fontSize,
              fontFamily: "Montserrat",
              shadows: [
                Shadow(color: kBlack, offset: Offset(_offset, _offset))
              ])));
}