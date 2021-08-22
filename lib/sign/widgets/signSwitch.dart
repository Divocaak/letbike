import 'package:flutter/material.dart';

class SignSwitch extends StatefulWidget {
  SignSwitch(this.label, this.value, this.inactive, this.active, {key})
      : super(key: key);

  final Widget label;
  bool value;
  final Color inactive;
  final Color active;

  @override
  _SignSwitchState createState() => _SignSwitchState();
}

class _SignSwitchState extends State<SignSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.label,
        Switch(
          value: widget.value,
          onChanged: (value) {
            setState(() {
              widget.value = value;
            });
          },
          inactiveTrackColor: widget.inactive,
          activeTrackColor: widget.active,
        ),
      ],
    );
  }
}
