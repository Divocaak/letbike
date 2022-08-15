import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/widgets/button_main.dart';

class PageBody extends StatelessWidget {
  const PageBody(
      {Key? key, required Widget body, required MainButton mainButton})
      : _body = body,
        _mainButton = mainButton,
        super(key: key);

  final Widget _body;
  final MainButton _mainButton;

  @override
  Widget build(BuildContext context) => SafeArea(
      child: Scaffold(
          floatingActionButton: _mainButton,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          backgroundColor: kBlack,
          body: Stack(children: [
            IgnorePointer(ignoring: false, child: Container(color: Colors.red)),
            _body
          ])));
}
