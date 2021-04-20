import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letbike/general/general.dart';

class FilterDropdown extends StatefulWidget {
  int value;

  final String hint;
  final List<String> options;
  FilterDropdown({Key key, this.hint, this.options}) : super(key: key);

  final _FilterDropdownState st = new _FilterDropdownState();
  void set() {
    st.setSt();
  }

  State<StatefulWidget> createState() => st;
}

class _FilterDropdownState extends State<FilterDropdown> {
  void setSt() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
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
  bool value = false;
  final String label;
  final String left;
  final String right;

  FilterSwitch({Key key, this.label, this.left, this.right}) : super(key: key);

  final _FilterSwitchState st = new _FilterSwitchState();
  void set() {
    st.setSt();
  }

  State<StatefulWidget> createState() => st;
}

class _FilterSwitchState extends State<FilterSwitch> {
  void setSt() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
            height: 50,
            width: 100,
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
            ])));
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
