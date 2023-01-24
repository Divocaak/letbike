import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/widgets/new/button_main.dart';

class PageBody extends StatelessWidget {
  const PageBody({Key? key, required Widget body, required MainButton mainButton})
      : _body = body,
        _mainButton = mainButton,
        super(key: key);

  final Widget _body;
  final MainButton _mainButton;

// TODO APP TEST ability to use background image widget
  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBlack,
      body: Stack(children: [SafeArea(child: _body), _mainButton]));
}
