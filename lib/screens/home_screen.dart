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
  late Future<List<Item>?> items;

  late AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    animationController.addListener(() => setState(() {}));
    items = RemoteItems.getAllItems(1, itemParams: widget._filters);

    loadNativeAd();

    super.initState();
  }

  late NativeAd _ad;
  bool isLoaded = false;

  void loadNativeAd() {
    _ad = NativeAd(
        adUnitId: "ca-app-pub-8451063166378874/4317911543",
        factoryId: "listTile",
        listener: NativeAdListener(
            onAdLoaded: (ad) => setState(() => isLoaded = true),
            onAdFailedToLoad: (ad, e) {
              ad.dispose();
              print("===");
              print(e);
              print(e.code);
              print(e.message);
              print(e.responseInfo);
              print("===");
            }),
        request: const AdRequest());

    _ad.load();
  }

  // ads
  /* @override
  void dispose() {
    super.dispose();
    _inlineAdaptiveAd?.dispose();
  }

  static const _insets = 16.0;
  BannerAd? _inlineAdaptiveAd;
  bool _isLoaded = false;
  AdSize? _adSize;
  late Orientation _currentOrientation;
  double get _adWidth => MediaQuery.of(context).size.width - (2 * _insets);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentOrientation = MediaQuery.of(context).orientation;
    _loadAd();
  }

  void _loadAd() async {
    await _inlineAdaptiveAd?.dispose();
    setState(() {
      _inlineAdaptiveAd = null;
      _isLoaded = false;
    });

    AdSize size = AdSize.getCurrentOrientationInlineAdaptiveBannerAdSize(
        _adWidth.truncate());

    _inlineAdaptiveAd = BannerAd(
        // TODO: replace this test ad unit with your own ad unit.
        adUnitId: 'ca-app-pub-3940256099942544/9214589741',
        size: size,
        request: AdRequest(),
        listener: BannerAdListener(onAdLoaded: (Ad ad) async {
          print('Inline adaptive banner loaded: ${ad.responseInfo}');
          BannerAd bannerAd = (ad as BannerAd);
          final AdSize? size = await bannerAd.getPlatformAdSize();
          if (size == null) {
            print('Error: getPlatformAdSize() returned null for $bannerAd');
            return;
          }

          setState(() {
            _inlineAdaptiveAd = bannerAd;
            _isLoaded = true;
            _adSize = size;
          });
        }, onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Inline adaptive banner failedToLoad: $error');
          ad.dispose();
        }));
    await _inlineAdaptiveAd!.load();
  }

  Widget _getAdWidget() => OrientationBuilder(
        builder: (context, orientation) {
          if (_currentOrientation == orientation &&
              _inlineAdaptiveAd != null &&
              _isLoaded &&
              _adSize != null) {
            return Align(
                child: Container(
                    width: _adWidth,
                    height: _adSize!.height.toDouble(),
                    child: AdWidget(ad: _inlineAdaptiveAd!)));
          }
          if (_currentOrientation != orientation) {
            _currentOrientation = orientation;
            _loadAd();
          }
          return Container();
        },
      ); */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: MainButton(
            iconData: Icons.menu,
            onPressed: () {
              if (animationController.isCompleted) {
                animationController.reverse();
                volume = 0;
              } else {
                animationController.forward();
                volume = 0.5;
              }
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        backgroundColor: kBlack,
        body: Stack(children: [
          SafeArea(
              child: RefreshIndicator(
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
                                return Center(
                                    child: Image.asset("assets/load.gif"));
                              default:
                                if (snapshot.hasError) {
                                  return ErrorWidgets.futureBuilderError();
                                } else if (!snapshot.hasData ||
                                    (snapshot.hasData &&
                                        snapshot.data!.length < 1))
                                  return ErrorWidgets.futureBuilderEmpty();
                                return ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, i) {
                                      if (isLoaded && i == 1) {
                                        return Container(
                                            child: AdWidget(ad: _ad),
                                            height: 200,
                                            color: Colors.lime);
                                      }

                                      return snapshot.data![i].buildCard(
                                          context, widget._loggedUser);
                                    });
                            }
                          })))),
          /* Container(color: kBlack, child: _getAdWidget()
              CardWidgets.cardsBuilder(items, false,
                      loggedUser: widget._loggedUser,
                      forRating: false,
                      touchable: true)
              ), */
          MainButtonClicked(buttons: [
            SecondaryButtonData(
                Icons.add,
                () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        AddItem(loggedUser: widget._loggedUser)))),
            SecondaryButtonData(
                Icons.filter_alt,
                () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        FilterPage(loggedUser: widget._loggedUser)))),
            SecondaryButtonData(
                Icons.person,
                () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        UserPage(loggedUser: widget._loggedUser)))),
            SecondaryButtonData(
                Icons.article,
                () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ArticlesScreen())))
          ], volume: volume)
        ]));
  }

  Future<void> _pullRefresh() async {
    Future<List<Item>?> _items =
        RemoteItems.getAllItems(1, itemParams: widget._filters);
    await Future.delayed(Duration(seconds: 1));
    items = _items;
    setState(() {});
  }
}
