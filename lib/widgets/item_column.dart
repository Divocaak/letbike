import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letbike/objects/item.dart';
import 'package:letbike/widgets/account_info.dart';
import 'package:letbike/widgets/error_widgets.dart';

class ItemColumn extends StatelessWidget {
  ItemColumn(
      {Key? key,
      required User user,
      required Future<List<Item>?> items,
      required String label,
      bool? touchable,
      TextEditingController? ratingController})
      : _user = user,
        _items = items,
        _label = label,
        _touchable = touchable ?? true,
        _ratingController = ratingController,
        super(key: key);

  final User _user;
  final Future<List<Item>?> _items;
  final String _label;
  final bool _touchable;
  final TextEditingController? _ratingController;

  @override
  Widget build(BuildContext context) => Column(children: [
        AccountInfoField(text: _label),
        Expanded(
            child: SizedBox.expand(
                child: FutureBuilder<List<Item>?>(
                    future: _items,
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
                                  .buildCard(context, _user,
                                      touchable: _touchable,
                                      ratingController: _ratingController));
                      }
                    })))
      ]);
}
