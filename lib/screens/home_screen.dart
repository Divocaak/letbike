import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:letbike/general/ad_handler.dart';
import 'package:letbike/objects/item.dart';
import 'package:letbike/objects/my_ad.dart';
import 'package:letbike/remote/items.dart';
import 'package:letbike/screens/add_item_screen.dart';
import 'package:letbike/screens/articles_screen.dart';
import 'package:letbike/screens/filter_screen.dart';
import 'package:letbike/screens/user_screen.dart';
import 'package:letbike/widgets/new/button_main.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/widgets/new/button_main_sub.dart';
import 'package:letbike/widgets/new/future_card_list.dart';
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
  late AdHandler adHandler;
  late List<MyAd?> ads;

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

    ads = [];
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
          FutureCardList(
            buildFunction: (object) =>
                (object as Item).buildCard(context, widget._loggedUser),
            fetchFunction: () =>
                RemoteItems.getAllItems(1, itemParams: filters),
            /* separatorFunction: (context, i) {
                if ((i + 1) % 3 == 0) {
                  if (ads[i] == null) {
                    ads.add(MyAd(
                        false,
                        NativeAd(
                            adUnitId: Platform.isAndroid
                                ? "ca-app-pub-8451063166378874/4317911543"
                                : "ca-app-pub-8451063166378874/2462469041",
                            factoryId: "listTile",
                            listener: NativeAdListener(
                                onAdLoaded: (Ad ad) =>
                                    setState(() => ads[i]!.loaded = true),
                                onAdFailedToLoad: (ad, e) => ad.dispose()),
                            request: const AdRequest())));
                    ads[i]!.ad.load();
                  }

                  return ads[i]!.buildAd();
                } else {
                  return Container();
                }
              } */
          ),
          // TODO ukrast na homepage
          //late Future<List<Item>?> savedItems;
          //savedItems = RemoteItems.getAllItems(1, saverId: widget._loggedUser.uid);
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
}
