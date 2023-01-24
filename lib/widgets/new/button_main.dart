import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/widgets/new/button_circular.dart';
import 'package:letbike/widgets/new/button_main_sub.dart';

class MainButton extends StatefulWidget {
  const MainButton({Key? key, IconData? iconData, Function? onPressed, List<MainButtonSub>? secondaryButtons})
      : _iconData = iconData,
        _onPressed = onPressed,
        _secondaryButtons = secondaryButtons,
        super(key: key);

  final IconData? _iconData;
  final Function? _onPressed;
  final List<MainButtonSub>? _secondaryButtons;

  @override
  MainButtonState createState() => MainButtonState();
}

class MainButtonState extends State<MainButton> {
  late bool showButtons;

  @override
  void initState() {
    showButtons = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Stack(alignment: AlignmentDirectional.bottomEnd, children: [
        IgnorePointer(ignoring: !showButtons, child: Container(color: kBlack.withOpacity(showButtons ? 0.7 : 0))),
        Padding(
            padding: const EdgeInsets.only(right: 25, bottom: 25),
            child:
                Column(verticalDirection: VerticalDirection.up, crossAxisAlignment: CrossAxisAlignment.end, children: [
              CircularButton(
                  color: kPrimaryColor,
                  size: 50,
                  icon: getSelfIcon(),
                  onClick: () {
                    if (widget._onPressed != null) {
                      widget._onPressed!();
                    } else {
                      setState(() => showButtons = !showButtons);
                    }
                  }),
              if (widget._secondaryButtons != null)
                Visibility(
                    visible: showButtons,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [for (MainButtonSub button in widget._secondaryButtons!) button]))
            ]))
      ]);

  IconData getSelfIcon() => widget._iconData == null ? (showButtons ? Icons.close : Icons.menu) : widget._iconData!;
}
