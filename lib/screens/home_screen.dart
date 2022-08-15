import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:letbike/objects/item.dart';
import 'package:letbike/screens/add_item_screen.dart';
import 'package:letbike/remote/items.dart';
import 'package:letbike/screens/user_screen.dart';
import 'package:letbike/screens/filter_screen.dart';
import 'package:letbike/screens/articles_screen.dart';
import 'package:letbike/widgets/button_main.dart';
import 'package:letbike/widgets/error_widgets.dart';
import 'package:letbike/widgets/button_main_clicked.dart';
import 'package:letbike/general/settings.dart';
//import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'dart:io' show Platform;

import 'package:letbike/widgets/new/page_body.dart';

double volume = 0;

class HomePage extends StatefulWidget {
  HomePage({Key? key, required User loggedUser, Map<String, String>? filters})
      : _loggedUser = loggedUser,
        _filters = filters,
        super(key: key);

  final User _loggedUser;
  final Map<String, String>? _filters;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late Map<int, Map<String, dynamic>> ads;
  late Future<List<Item>?> items;

  late AnimationController animationController;

  @override
  void initState() {
    ads = {};
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    animationController.addListener(() => setState(() {}));
    items = RemoteItems.getAllItems(1, itemParams: widget._filters);

    MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
        testDeviceIds: [
          '33BE2250B43518CCDA7DE426D04EE231',
          '0faf99b3cf596954617f26a2639b9681'
        ]));

    super.initState();
  }

  @override
  Widget build(BuildContext context) => PageBody(
      body: RefreshIndicator(
          onRefresh: _pullRefresh,
          backgroundColor: Colors.transparent,
          color: kPrimaryColor,
          strokeWidth: 5,
          child: SizedBox.expand(
              child: FutureBuilder<List<Item>?>(
                  future: items,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: Image.asset("assets/load.gif"));
                      default:
                        if (snapshot.hasError) {
                          return ErrorWidgets.futureBuilderError();
                        } else if (!snapshot.hasData ||
                            (snapshot.hasData && snapshot.data!.length < 1))
                          return ErrorWidgets.futureBuilderEmpty();
                        return ListView.separated(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, i) {
                              return snapshot.data![i]
                                  .buildCard(context, widget._loggedUser);
                            },
                            separatorBuilder: (context, i) {
                              if ((i + 1) % 3 == 0) {
                                if (ads[i] == null) {
                                  ads[i] = {};
                                  ads[i]!["loaded"] = false;
                                  ads[i]!["ad"] = NativeAd(
                                      adUnitId: Platform.isAndroid
                                          ? "ca-app-pub-8451063166378874/4317911543"
                                          : "ca-app-pub-8451063166378874/2462469041",
                                      factoryId: "listTile",
                                      listener: NativeAdListener(
                                          onAdLoaded: (Ad ad) => setState(
                                              () => ads[i]!["loaded"] = true),
                                          onAdFailedToLoad: (ad, e) {
                                            ad.dispose();
                                            print(e);
                                          }),
                                      request: const AdRequest());
                                  ads[i]!["ad"].load();
                                }

                                return ads[i]!["loaded"]
                                    ? Container(
                                        height: 100,
                                        child: Card(
                                            clipBehavior: Clip.antiAlias,
                                            elevation: 0,
                                            color: kWhite.withOpacity(.2),
                                            margin: const EdgeInsets.all(5),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: AdWidget(ad: ads[i]!["ad"])))
                                    : CircularProgressIndicator();
                              } else {
                                return Container();
                              }
                            });
                    }
                  }))),
      mainButton: MainButton(
          iconData: Icons.menu,
          showButtons: !animationController.isCompleted,
          onPressed: () {
            if (animationController.isCompleted) {
              animationController.reverse();
              volume = 0;
            } else {
              animationController.forward();
              volume = 0.5;
            }
          }));

  Future<void> _pullRefresh() async {
    Future<List<Item>?> _items =
        RemoteItems.getAllItems(1, itemParams: widget._filters);
    await Future.delayed(Duration(seconds: 1));
    items = _items;
    setState(() {});
  }
}
