import 'package:flutter/material.dart';
import 'package:letbike/general/pallete.dart';

class TextInput extends StatelessWidget {
  const TextInput(
      {Key? key,
      required IconData icon,
      required String hint,
      required TextEditingController controller,
      required bool obscure,
      TextInputType? inputType,
      TextInputAction? inputAction,
      String? validationIdentity})
      : _icon = icon,
        _hint = hint,
        _controller = controller,
        _inputType = inputType,
        _inputAction = inputAction,
        _obscure = obscure,
        _validationIdentity = validationIdentity,
        super(key: key);

  final IconData _icon;
  final String _hint;
  final TextEditingController _controller;
  final bool _obscure;
  final TextInputType? _inputType;
  final TextInputAction? _inputAction;
  final String? _validationIdentity;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 10 * 5.5,
        width: size.width * 0.8,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: kSecondaryColor,
        ),
        child: Center(
          child: TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(_icon, size: 28, color: kWhite),
              ),
              hintText: _hint,
            ),
            obscureText: _obscure,
            keyboardType: _inputType,
            textInputAction: _inputAction,
            validator: (String? value) {
              if (_validationIdentity != "" && _validationIdentity != null) {
                if (value!.isEmpty) {
                  return "Zadejte " + _hint;
                }

                if (_validationIdentity == "regMail" ||
                    _validationIdentity == "logMail") {
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return "Zadejte platný e-mail";
                  }
                }

                if ((_validationIdentity == "regPass" && value.length < 8) ||
                    (_validationIdentity == "changePassNew" &&
                        value.length < 8)) {
                  return "Heslo musí obsahovat minimálně 8 znaků";
                }
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
