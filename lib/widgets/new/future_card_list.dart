import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/widgets/error_widgets.dart';

class FutureCardList extends StatefulWidget {
  FutureCardList(
      {Key? key,
      required Function(dynamic objectToCard) buildFunction,
      required Function fetchFunction,
      Function(BuildContext, int)? separatorFunction})
      : _buildFunction = buildFunction,
        _fetchFunction = fetchFunction,
        _separatorFunction = separatorFunction,
        super(key: key);

  final Function(dynamic objectToCard) _buildFunction;
  final Function _fetchFunction;
  final Function(BuildContext, int)? _separatorFunction;

  @override
  FutureCardListState createState() => FutureCardListState();
}

class FutureCardListState extends State<FutureCardList> {
  late Future<List?> futureList;

  @override
  void initState() {
    futureList = widget._fetchFunction();
    super.initState();
  }

// TODO use on homepage
  @override
  Widget build(BuildContext context) => Expanded(
      child: RefreshIndicator(
          color: kPrimaryColor,
          strokeWidth: 5,
          onRefresh: () async {
            futureList = widget._fetchFunction();
            setState(() {});
          },
          child: FutureBuilder<List?>(
              future: futureList,
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
                    return widget._separatorFunction == null
                        ? ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, i) =>
                                widget._buildFunction(snapshot.data![i]))
                        : ListView.separated(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, i) =>
                                widget._buildFunction(snapshot.data![i]),
                            separatorBuilder: (context, i) =>
                                widget._separatorFunction!(context, i));
                }
              })));
}
