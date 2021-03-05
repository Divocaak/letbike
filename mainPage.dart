import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:letbike/partPage.dart';
import "dbServices.dart";

void main() async {
  runApp(MyApp());

  /* ItemDB().addItem(0, "", "", 00.00, 0, 0,
      DateTime.parse("1969-07-20 20:18:04Z"), "0.jpg|1.jpg|2.jpg", 0); */

  var itemsJson = jsonDecode(await DatabaseServices().getItems());
  print(itemsJson);
  List dynList = itemsJson.map((partJson) => Item.fromJson(partJson)).toList();
  List<Item> itemList = dynList.map((s) => s as Item).toList();
}

double volume = 0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
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
      //AppBar
      appBar: new AppBar(
        title: new Text(
          "Appka",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.black87,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
          color: Colors.grey,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            color: Colors.grey,
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.black,
            child: //ListView(
                //children: <Widget>[
                FutureBuilder(
              future: DatabaseServices().getItems(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                List snap = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print("loading data");
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  print("error");
                  return Center(
                    child: Text(
                      "Error fetching data",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  );
                }

                return ListView.builder(
                    itemCount: snap.length,
                    itemBuilder: (context, index) {
                      return _buildCard(
                          "asd", "dsa", 0.0, 0, 0, "dateEnd", "imgs");
                    });
              },
              //)
              //],
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

  Widget _buildCard(String name, String description, double price, int score,
      int paid, String dateEnd, String imgs) {
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
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new ProductPage()),
                );
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
                    name,
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
                    description,
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
                price.toString(),
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
