import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';

class FilterSwitchable extends StatefulWidget {
  FilterSwitchable(
      {Key? key,
      required String label,
      required String leftOption,
      required String rightOption})
      : _label = label,
        _leftOption = leftOption,
        _rightOption = rightOption,
        super(key: key);

  final String _label;
  final String _leftOption;
  final String _rightOption;
  int? _value;

  bool? getValue() {
    switch (_value) {
      case 0:
        return false;
      case 1:
        return null;
      case 2:
        return true;
    }
  }

  @override
  FilterSwitchableState createState() => FilterSwitchableState();
}

class FilterSwitchableState extends State<FilterSwitchable> {
  final List<bool> selected = [false, true, false];
  @override
  Widget build(BuildContext context) => Row(children: [
        Text(widget._label + ": ", style: TextStyle(color: kWhite)),
        ToggleButtons(
            direction: Axis.horizontal,
            onPressed: (int index) => setState(() {
                  widget._value = index;
                  for (int i = 0; i < 2; i++) {
                    selected[i] = i == index;
                  }
                }),
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            selectedBorderColor: kPrimaryColor,
            selectedColor: kWhite,
            fillColor: kPrimaryColor,
            color: kWhite,
            isSelected: selected,
            children: [
              Text(widget._leftOption),
              Text("-"),
              Text(widget._rightOption)
            ])
      ]);
}
