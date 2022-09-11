import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/objects/item.dart';
import 'package:letbike/widgets/error_widgets.dart';

class ItemColumn extends StatefulWidget {
  ItemColumn(
      {Key? key,
      required User user,
      required Function fetch,
      bool? touchable,
      TextEditingController? ratingController})
      : _user = user,
        _fetch = fetch,
        _touchable = touchable ?? true,
        _ratingController = ratingController,
        super(key: key);

  final User _user;
  final Function _fetch;
  final bool _touchable;
  final TextEditingController? _ratingController;

  @override
  ItemColumnState createState() => ItemColumnState();
}

class ItemColumnState extends State<ItemColumn> {
  late Future<List<Item>?> items;

  @override
  void initState() {
    items = widget._fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Expanded(
      child: RefreshIndicator(
          // TODO do not repeat yourself
          color: kPrimaryColor,
          strokeWidth: 5,
          onRefresh: () async {
            // TODO otestovat proti db
            items = widget._fetch();
          },
          child: FutureBuilder<List<Item>?>(
              future: items,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: Image.asset("assets/load.gif"));
                  default:
                    if (snapshot.hasError)
                      return ErrorWidgets.futureBuilderError();
                    else if (!snapshot.hasData ||
                        (snapshot.hasData && snapshot.data!.length < 1))
                      return ErrorWidgets.futureBuilderEmpty();
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) => snapshot.data![i]
                            .buildCard(context, widget._user,
                                touchable: widget._touchable,
                                ratingController: widget._ratingController));
                }
              })));
}
