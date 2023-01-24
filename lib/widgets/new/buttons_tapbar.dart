import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';

class ButtonsTapBarStyled extends StatelessWidget {
  const ButtonsTapBarStyled({Key? key, required List<Widget> tabs, TabController? controller})
      : _tabs = tabs,
        _controller = controller,
        super(key: key);

  final List<Widget> _tabs;
  final TabController? _controller;

  @override
  Widget build(BuildContext context) => ButtonsTabBar(
      controller: _controller,
      backgroundColor: kPrimaryColor,
      unselectedBackgroundColor: kSecondaryColor,
      labelStyle: const TextStyle(color: kWhite),
      unselectedLabelStyle: const TextStyle(color: kWhite),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      tabs: _tabs);
}
