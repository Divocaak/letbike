import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:letbike/general/ad_handler.dart';
import 'package:letbike/objects/item.dart';
import 'package:letbike/remote/items.dart';
import 'package:letbike/screens/add_item_screen.dart';
import 'package:letbike/screens/articles_screen.dart';
import 'package:letbike/screens/filter_screen.dart';
import 'package:letbike/screens/user_screen.dart';
import 'package:letbike/widgets/new/button_main.dart';
import 'package:letbike/widgets/error_widgets.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/widgets/new/button_main_sub.dart';
import 'dart:io' show Platform;
import 'package:letbike/widgets/new/page_body.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required User loggedUser})
      : _loggedUser = loggedUser,
        super(key: key);

  final User _loggedUser;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late Map<int, Map<String, dynamic>> ads;

  late AnimationController animationController;
  late AdHandler adHandler;

  late TabController tabController;

  Map<String, String>? filters;

  late bool showResetFilterBtn;

  @override
  void initState() {
    showResetFilterBtn = false;
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      if (filters != null) {
        setState(() => (showResetFilterBtn = tabController.index == 0));
      }
    });

    ads = {};
    MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
        testDeviceIds: [
          '33BE2250B43518CCDA7DE426D04EE231',
          '0faf99b3cf596954617f26a2639b9681'
        ]));

    super.initState();
  }

  @override
  Widget build(BuildContext context) => PageBody(
      body: Column(children: <Widget>[
        ButtonsTabBar(
          // TODO do not repeat yourself
            controller: tabController,
            backgroundColor: kPrimaryColor,
            unselectedBackgroundColor: kSecondaryColor,
            labelStyle: TextStyle(color: kWhite),
            unselectedLabelStyle: TextStyle(color: kWhite),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            tabs: [
              Tab(icon: Icon(Icons.directions_bike), text: "Všechny"),
              Tab(icon: Icon(Icons.favorite), text: "Oblíbené"),
              Tab(
                  icon: Icon(
                      Icons.notifications /* Icons.notifications_active */),
                  text: "Oznámení")
            ]),
        if (showResetFilterBtn)
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              child: TextButton(
                  onPressed: () => setState(() {
                        filters = null;
                        showResetFilterBtn = false;
                      }),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.filter_alt_off, color: kWhite),
                        Text("Resetovat filtry",
                            style: TextStyle(color: kWhite))
                      ]))),
        Expanded(
            child: TabBarView(controller: tabController, children: [
          RefreshIndicator(
              onRefresh: _pullRefresh,
              color: kPrimaryColor,
              strokeWidth: 5,
              child: SizedBox.expand(
                  child: FutureBuilder<List<Item>?>(
                      future: RemoteItems.getAllItems(1, itemParams: filters),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(
                                child: Image.asset("assets/load.gif"));
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
                                                  () =>
                                                      ads[i]!["loaded"] = true),
                                              onAdFailedToLoad: (ad, e) {
                                                ad.dispose();
                                                print(e);
                                              }),
                                          request: const AdRequest());
                                      ads[i]!["ad"].load();
                                    }

                                    return ads[i]!["loaded"]
                                        ? Container(
                                            height: 150,
                                            child: Card(
                                                clipBehavior: Clip.antiAlias,
                                                elevation: 0,
                                                color: kWhite.withOpacity(.2),
                                                margin: const EdgeInsets.all(5),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: AdWidget(
                                                    ad: ads[i]!["ad"])))
                                        : CircularProgressIndicator();
                                  } else {
                                    return Container();
                                  }
                                });
                        }
                      }))),
          Text("b"),
          Text("c")
        ]))
      ]),
      mainButton: MainButton(secondaryButtons: [
        MainButtonSub(icon: Icons.settings, label: "Nastavení", onClick: () {}),
        MainButtonSub(
            icon: Icons.article,
            label: "Články",
            onClick: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (builder) => ArticlesScreen()))),
        MainButtonSub(
            icon: Icons.person,
            label: "Můj účet",
            onClick: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (builder) =>
                    UserPage(loggedUser: widget._loggedUser)))),
        MainButtonSub(
            icon: Icons.filter_alt,
            label: "Filtrovat",
            onClick: () async {
              filters = await Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) =>
                      FilterPage(loggedUser: widget._loggedUser)));
              if (!mounted) return;
              setState(() {});
              tabController.animateTo(0);
            }),
        MainButtonSub(
            icon: Icons.add,
            label: "Přidat inzerát",
            onClick: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (builder) => AddItem(loggedUser: widget._loggedUser))))
      ]));

  Future<void> _pullRefresh() async {
    // TODO mby todo?
    widget.createState();
  }
}
