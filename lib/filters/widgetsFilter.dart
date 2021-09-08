import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letbike/filters/filters.dart';
import 'package:letbike/general/pallete.dart';

class FilterDropdown extends StatefulWidget {
  FilterDropdown(
      {Key key,
      @required this.hint,
      @required this.options,
      @required this.filterKey,
      this.fp})
      : super(key: key);

  int value;
  final String hint;
  final List<String> options;
  final String filterKey;
  State<FilterPage> fp;

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
          hint: Text(widget.hint, style: TextStyle(color: kWhite)),
          dropdownColor: kBlack,
          value: widget.value,
          onChanged: (newValue) {
            setState(() {
              widget.value = newValue;
            });

            if (widget.fp != null) widget.fp.setState(() {});
          },
          items: widget.options.asMap().entries.map((entry) {
            return DropdownMenuItem(
              child: new Text(entry.value, style: TextStyle(color: kWhite)),
              value: entry.key,
            );
          }).toList(),
        ));
  }
}

class FilterSwitch extends StatefulWidget {
  FilterSwitch(
      {Key key,
      @required this.label,
      @required this.left,
      @required this.right,
      @required this.filterKey,
      this.fp})
      : super(key: key);

  bool value = false;
  final String label;
  final String left;
  final String right;
  final String filterKey;
  State<FilterPage> fp;

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
          Text(widget.label + ": " + widget.left,
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

              if (widget.fp != null) widget.fp.setState(() {});
            },
          ),
          Text(" " + widget.right, style: TextStyle(color: kWhite))
        ]));
  }
}
