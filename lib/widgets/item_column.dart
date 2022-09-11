import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/objects/item.dart';
import 'package:letbike/remote/items.dart';
import 'package:letbike/widgets/error_widgets.dart';

class ItemColumn extends StatefulWidget {
  ItemColumn(
      {Key? key,
      required User user,
      required int itemStatus,
      String? sellerId,
      Map<String, String>? itemParams,
      String? soldTo,
      String? saverId,
      bool? touchable,
      TextEditingController? ratingController})
      : _user = user,
        _itemStatus = itemStatus,
        _sellerId = sellerId,
        _itemParams = itemParams,
        _soldTo = soldTo,
        _saverId = saverId,
        _touchable = touchable ?? true,
        _ratingController = ratingController,
        super(key: key);

  final User _user;
  final int _itemStatus;
  final String? _sellerId;
  final Map<String, String>? _itemParams;
  final String? _soldTo;
  final String? _saverId;
  final bool _touchable;
  final TextEditingController? _ratingController;

  @override
  ItemColumnState createState() => ItemColumnState();
}

class ItemColumnState extends State<ItemColumn> {
  late Future<List<Item>?> items;

  @override
  void initState() {
    items = RemoteItems.getAllItems(widget._itemStatus,
        sellerId: widget._sellerId,
        itemParams: widget._itemParams,
        soldTo: widget._soldTo,
        saverId: widget._saverId);
    super.initState();
  }

// TODO use on homepage
  @override
  Widget build(BuildContext context) => Expanded(
      child: RefreshIndicator(
          // TODO do not repeat yourself
          color: kPrimaryColor,
          strokeWidth: 5,
          onRefresh: () async {
            items = RemoteItems.getAllItems(widget._itemStatus,
                sellerId: widget._sellerId,
                itemParams: widget._itemParams,
                soldTo: widget._soldTo,
                saverId: widget._saverId);
            setState(() {});
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
