import 'package:flutter/material.dart';
import 'package:letbike/screens/filter_screen.dart';
import 'package:letbike/general/settings.dart';

// ignore: must_be_immutable
class FilterSwitch extends StatefulWidget {
  FilterSwitch(
      {Key? key,
      required String label,
      required String left,
      required String right,
      required String filterKey})
      : _label = label,
        _left = left,
        _right = right,
        _filterKey = filterKey,
        super(key: key);

  bool value = false;
  final String _label;
  final String _left;
  final String _right;
  // ignore: unused_field
  final String _filterKey;
  State<FilterPage>? _fp;

  setFp(input) => _fp = input;
  getKey() => _filterKey;

  State<StatefulWidget> createState() => _FilterSwitchState();
}

class _FilterSwitchState extends State<FilterSwitch> {
  @override
  Widget build(BuildContext context) => Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
          color: kBlack.withAlpha(128),
          border: Border.all(color: kWhite.withAlpha(128)),
          borderRadius: BorderRadius.circular(25)),
      child: Row(children: [
        Text(widget._label + ": " + widget._left,
            style: TextStyle(color: kWhite)),
        Switch(
            inactiveTrackColor: kError,
            activeTrackColor: kGreen,
            activeColor: kSecondaryColor,
            inactiveThumbColor: kPrimaryColor,
            value: widget.value,
            onChanged: (value) {
              setState(() => widget.value = value);
              if (widget._fp != null) widget._fp!.setState(() {});
            }),
        Text(" " + widget._right, style: TextStyle(color: kWhite))
      ]));
}
