import "package:flutter/material.dart";
import 'package:letbike/general/settings.dart';
import 'package:letbike/widgets/image_server.dart';

class CardBody extends StatelessWidget {
  const CardBody({Key? key, required Function onTap, required String imgPath, required Widget child})
      : _onTap = onTap,
        _imgPath = imgPath,
        _child = child,
        super(key: key);

  final Function _onTap;
  final String _imgPath;
  final Widget _child;

  @override
  Widget build(BuildContext context) => SizedBox(
      height: 240,
      child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          color: kWhite.withOpacity(.05),
          margin: const EdgeInsets.all(5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child:
              InkWell(onTap: () => _onTap(), child: Stack(children: [ServerImage(path: "$_imgPath/0.jpg"), _child]))));
}
