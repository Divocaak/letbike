import 'package:flutter/material.dart';
import 'package:letbike/filters/filters.dart';
import 'package:letbike/general/pallete.dart';

// ignore: must_be_immutable
class FilterDropdown extends StatefulWidget {
  FilterDropdown(
      {Key? key,
      required String hint,
      required List<String> options,
      required String filterKey,
      State<FilterPage>? fp})
      : _hint = hint,
        _options = options,
        _filterKey = filterKey,
        _fp = fp,
        super(key: key);

  late int value;
  final String _hint;
  final List<String> _options;
  // ignore: unused_field
  final String _filterKey;
  State<FilterPage>? _fp;

  State<StatefulWidget> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          color: kBlack.withAlpha(128),
          border: Border.all(color: kWhite.withAlpha(128)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: DropdownButton(
          hint: Text(widget._hint, style: TextStyle(color: kWhite)),
          dropdownColor: kBlack,
          value: widget.value,
          onChanged: (newValue) {
            setState(() {
              widget.value = newValue as int;
            });

            if (widget._fp != null) widget._fp!.setState(() {});
          },
          items: widget._options.asMap().entries.map((entry) {
            return DropdownMenuItem(
              child: new Text(entry.value, style: TextStyle(color: kWhite)),
              value: entry.key,
            );
          }).toList(),
        ));
  }
}

// ignore: must_be_immutable
class FilterSwitch extends StatefulWidget {
  FilterSwitch(
      {Key? key,
      required String label,
      required String left,
      required String right,
      required String filterKey,
      State<FilterPage>? fp})
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

  State<StatefulWidget> createState() => _FilterSwitchState();
}

class _FilterSwitchState extends State<FilterSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          color: kBlack.withAlpha(128),
          border: Border.all(color: kWhite.withAlpha(128)),
          borderRadius: BorderRadius.circular(25),
        ),
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
              setState(() {
                widget.value = value;
              });

              if (widget._fp != null) widget._fp!.setState(() {});
            },
          ),
          Text(" " + widget._right, style: TextStyle(color: kWhite))
        ]));
  }
}
