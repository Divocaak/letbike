import "package:flutter/material.dart";
import 'package:letbike/general/settings.dart';
import 'package:letbike/widgets/images.dart';

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

class CardBody extends StatelessWidget {
  const CardBody(
      {Key? key,
      required Function onTap,
      required String imgPath,
      required Widget child})
      : _onTap = onTap,
        _imgPath = imgPath,
        _child = child,
        super(key: key);

  final Function _onTap;
  final String _imgPath;
  final Widget _child;

  @override
  Widget build(BuildContext context) => Container(
      height: 240,
      child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          color: kWhite.withOpacity(.05),
          margin: const EdgeInsets.all(5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: InkWell(
              onTap: () => _onTap(),
              child: Stack(children: [
                ServerImage(path: _imgPath + "/0.jpg"),
                _child
              ]))));
}
