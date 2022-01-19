import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';

// ignore: must_be_immutable
class RatingBar extends StatefulWidget {
  RatingBar({key}) : super(key: key);
  double rating = 5;

  getRatingVal() => rating.toInt();

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  @override
  Widget build(BuildContext context) => Column(children: [
        Text("Hodnocení: " + widget.rating.toInt().toString(),
            style: TextStyle(color: kWhite)),
        Slider(
            value: widget.rating,
            min: 0,
            max: 10,
            divisions: 10,
            inactiveColor: kSecondaryColor,
            activeColor: kPrimaryColor,
            onChanged: (double value) => setState(
                () => widget.rating = double.parse(value.toStringAsFixed(1))))
      ]);
}
