import 'package:flutter/material.dart';
import 'package:letbike/settings.dart';

class TextInput extends StatelessWidget {
  const TextInput(
      {Key? key,
      required IconData icon,
      required String hint,
      required TextEditingController controller,
      TextInputType? inputType,
      TextInputAction? inputAction})
      : _icon = icon,
        _hint = hint,
        _controller = controller,
        _inputType = inputType,
        _inputAction = inputAction,
        super(key: key);

  final IconData _icon;
  final String _hint;
  final TextEditingController _controller;
  final TextInputType? _inputType;
  final TextInputAction? _inputAction;

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
          height: 10 * 5.5,
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: kSecondaryColor),
          child: Center(
              child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Icon(_icon, size: 28, color: kWhite)),
                      hintText: _hint),
                  keyboardType: _inputType,
                  textInputAction: _inputAction))));
}
