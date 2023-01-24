import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';

class ParamSwitchable extends StatefulWidget {
  ParamSwitchable({Key? key, required String label, required String leftOption, required String rightOption})
      : _label = label,
        _leftOption = leftOption,
        _rightOption = rightOption,
        super(key: key);

  final String _label;
  final String _leftOption;
  final String _rightOption;
  int? _value;

  int? getValue() => _value != 1 ? _value : null;

  @override
  ParamSwitchableState createState() => ParamSwitchableState();
}

class ParamSwitchableState extends State<ParamSwitchable> {
  final List<bool> selected = [false, true, false];
  @override
  Widget build(BuildContext context) => Row(children: [
        Text("${widget._label}: ", style: const TextStyle(color: kWhite)),
        ToggleButtons(
            direction: Axis.horizontal,
            onPressed: (int index) => setState(() {
                  widget._value = index;
                  for (int i = 0; i <= 2; i++) {
                    selected[i] = i == index;
                  }
                }),
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            selectedBorderColor: kPrimaryColor,
            selectedColor: kWhite,
            fillColor: kPrimaryColor,
            color: kWhite,
            isSelected: selected,
            children: [Text(widget._leftOption), const Text("-"), Text(widget._rightOption)])
      ]);
}
