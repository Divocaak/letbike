import 'dart:ui';
import 'package:flutter/material.dart';
import 'itemPage.dart';
import "../general/dbServices.dart";

double volume = 0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  static const routeName = "/homePage";
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Future<List<Item>> items;
  User loggedUser;

  AnimationController animationController;
  Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  Animation rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void initState() {
    items = DatabaseServices.getAllItems("id");
    loggedUser = ModalRoute.of(context).settings.arguments;

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0)
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0)
    ]).animate(animationController);
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0)
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black,
            child: FutureBuilder<List<Item>>(
              future: items,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return _buildCard(snapshot.data[i]);
                      });
                } else if (snapshot.hasError) {
                  return Text('Sorry there is an error');
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          IgnorePointer(
            ignoring: true,
            child: Container(
              color: Colors.black.withOpacity(volume),
            ),
          ),
          Stack(
            children: <Widget>[
              Positioned(
                  right: 30,
                  bottom: 30,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset.fromDirection(getRadiansFromDegree(270),
                            degOneTranslationAnimation.value * 100),
                        child: Transform(
                          transform: Matrix4.rotationZ(
                              getRadiansFromDegree(rotationAnimation.value))
                            ..scale(degOneTranslationAnimation.value),
                          alignment: Alignment.center,
                          child: _CircularButton(
                            color: Colors.green,
                            width: 50,
                            heigt: 50,
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onClick: () {},
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset.fromDirection(getRadiansFromDegree(225),
                            degTwoTranslationAnimation.value * 100),
                        child: Transform(
                          transform: Matrix4.rotationZ(
                              getRadiansFromDegree(rotationAnimation.value))
                            ..scale(degTwoTranslationAnimation.value),
                          alignment: Alignment.center,
                          child: _CircularButton(
                            color: Colors.green,
                            width: 50,
                            heigt: 50,
                            icon: Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            onClick: () {},
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset.fromDirection(getRadiansFromDegree(180),
                            degThreeTranslationAnimation.value * 100),
                        child: Transform(
                          transform: Matrix4.rotationZ(
                              getRadiansFromDegree(rotationAnimation.value))
                            ..scale(degThreeTranslationAnimation.value),
                          alignment: Alignment.center,
                          child: _CircularButton(
                            color: Colors.green,
                            width: 50,
                            heigt: 50,
                            icon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            onClick: () {},
                          ),
                        ),
                      ),
                      _CircularButton(
                        color: Colors.greenAccent,
                        width: 60,
                        heigt: 60,
                        icon: Icon(
                          Icons.menu,
                          color: Colors.black,
                        ),
                        onClick: () {
                          if (animationController.isCompleted) {
                            animationController.reverse();
                            volume = 0;
                          } else {
                            animationController.forward();
                            volume = 0.5;
                          }
                        },
                      ),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Item item) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: Colors.black,
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Ink.image(
            image: NetworkImage(
                'http://www.hybrid.cz/i/auto/samorost-plzen-drevo-horske-kolo.jpeg'),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(ItemPage.routeName,
                    arguments: new ItemInfo(item, loggedUser));
              },
            ),
            height: 240,
            fit: BoxFit.cover,
            padding: const EdgeInsets.all(50),
          ),
          Positioned(
            left: 16,
            bottom: 32,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    item.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 32,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(4, 1),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    item.description,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(4, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 16,
            bottom: 32,
            child: Container(
              child: Text(
                item.price.toString() + "Kč",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 32,
                  fontFamily: "Montserrat",
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(4, 1),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBlur({
    @required Widget child,
    BorderRadius borderRadius,
    double sigmaX = 10,
    double sigmaY = 10,
  }) =>
      ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
          child: child,
        ),
      );
}

class _CircularButton extends StatelessWidget {
  final double width;
  final double heigt;
  final Color color;
  final Icon icon;
  final Function onClick;

  _CircularButton(
      {this.color, this.width, this.heigt, this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: heigt,
      child: IconButton(
        icon: icon,
        enableFeedback: true,
        onPressed: onClick,
      ),
    );
  }
}

class ItemInfo {
  Item item;
  User me;

  ItemInfo(this.item, this.me);
}
