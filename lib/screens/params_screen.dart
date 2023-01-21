import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:letbike/objects/params/param.dart';
import 'package:letbike/screens/home_screen.dart';
import 'package:letbike/widgets/new/button_main.dart';
import 'package:letbike/remote/items.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/widgets/alert_box.dart';
import 'package:letbike/widgets/error_widgets.dart';
import 'package:letbike/widgets/new/page_body.dart';

class ParamsPage extends StatefulWidget {
  ParamsPage(
      {Key? key,
      required User loggedUser,
      required List<Param> params,
      String? name,
      String? desc,
      String? price,
      List<XFile>? images})
      : _loggedUser = loggedUser,
        _params = params,
        _name = name,
        _desc = desc,
        _price = price,
        _images = images,
        super(key: key);

  final User _loggedUser;
  final List<Param> _params;
  final String? _name;
  final String? _desc;
  final String? _price;
  final List<XFile>? _images;

  @override
  _ParamsPage createState() => _ParamsPage();
}

// TODO load already set filters
class _ParamsPage extends State<ParamsPage> {
  late List<Param> params;

  @override
  Widget build(BuildContext context) => PageBody(
      body: SingleChildScrollView(child: Column(children: buildParams(context))),
      mainButton: MainButton(
          iconData: widget._name == null ? Icons.save : Icons.add,
          onPressed: () {
            if (widget._name == null) {
              Navigator.of(context).pop(getParams());
            } else {
              ModalWindow.showModalWindow(
                  context,
                  "Oznámení",
                  FutureBuilder<bool>(
                      // TODO thumbnail separation
                      future: RemoteItems.addItem(widget._loggedUser.uid, widget._name!, widget._desc!, widget._price!,
                          widget._images![0], widget._images!, getParams()),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(child: Image.asset("assets/load.gif"));
                          default:
                            if (snapshot.hasError)
                              return ErrorWidgets.futureBuilderError();
                            else if (!snapshot.hasData) return ErrorWidgets.futureBuilderEmpty();
                            return Text("Inzerát úspěšně přidán", style: TextStyle(color: kWhite));
                        }
                      }),
                  after: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => HomePage(loggedUser: widget._loggedUser, params: widget._params))));
            }
          }));

  List<Widget> buildParams(BuildContext context) {
    List<Widget> toRet = [];
    params = [];
    widget._params.forEach((element) {
      params.add(element);
      toRet.add(element.buildParam(context));
    });
    return toRet;
  }

  Map<String, int>? getParams() {
    Map<String, int> toRet = {};
    params.forEach((element) => toRet.addAll(element.getParams()));
    return toRet.isNotEmpty ? toRet : null;
  }
}
