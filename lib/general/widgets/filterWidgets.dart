import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letbike/app/filterPage.dart';
import 'package:letbike/general/general.dart';

class FilterDropdown extends StatefulWidget {
  FilterDropdown({Key key, this.hint, this.options, this.fp})
      : super(key: key);

  int value;
  final String hint;
  final List<String> options;
  State<FilterPage> fp;

  State<StatefulWidget> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: kWhite,
          border: Border.all(
            color: kWhite,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: DropdownButton(
          hint: Text(widget.hint),
          value: widget.value,
          onChanged: (newValue) {
            setState(() {
              widget.value = newValue;
            });

            if(widget.fp != null) widget.fp.setState(() {});
          },
          items: widget.options.asMap().entries.map((entry) {
            return DropdownMenuItem(
              child: new Text(entry.value),
              value: entry.key,
            );
          }).toList(),
        ));
  }
}

class FilterSwitch extends StatefulWidget {
  FilterSwitch({Key key, this.label, this.left, this.right}) : super(key: key);

  bool value = false;
  final String label;
  final String left;
  final String right;

  State<StatefulWidget> createState() => _FilterSwitchState();
}

class _FilterSwitchState extends State<FilterSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: kWhite,
          border: Border.all(
            color: kWhite,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(children: [
          Text(widget.label + ": " + widget.left),
          Switch(
            value: widget.value,
            onChanged: (value) {
              setState(() {
                widget.value = value;
              });
            },
          ),
          Text(" " + widget.right)
        ]));
  }
}

class FilterValueSetters {
  static int setDropdownValue(int dropdownValue) {
    return (dropdownValue != null ? dropdownValue : -1);
  }

  static int setSwitchValueWithOffset(bool switchValue, ItemParams params) {
    return ((switchValue ? 1 : 0) +
        (params.params["selectedPart"] != null
            ? params.params["selectedPart"]
            : 0) +
        (params.params["selectedOther"] != null
            ? params.params["selectedOther"]
            : 0) +
        999);
  }
}
