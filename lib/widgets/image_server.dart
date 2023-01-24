import 'package:flutter/material.dart';
import 'package:letbike/widgets/error_widgets.dart';

class ServerImage extends StatelessWidget {
  const ServerImage({Key? key, required String path})
      : _path = path,
        super(key: key);

  final String _path;

  @override
  Widget build(BuildContext context) => Center(
      child: FadeInImage.assetNetwork(
          fit: BoxFit.fitWidth,
          placeholder: 'assets/load.gif',
          image: _path,
          imageErrorBuilder: (context, exception, stackTrace) => ErrorWidgets.imageLoadingError(Icons.image)));
}
