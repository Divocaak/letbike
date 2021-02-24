import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:letbike/part.dart';

void main() {
  runApp(MyApp());
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
            child: ListView(
              children: [
                _buildCard("Karel ", "BMX", "12 000 Kč", true),
                _buildCard("Karel", "BMX", "12 000 Kč", true),
                _buildCard("Karel", "BMX", "12 000 Kč", true),
                _buildCard("Karel", "BMX", "12 000 Kč", true),
                _buildCard("Karel", "BMX", "12 000 Kč", true),
                _buildCard("Karel", "BMX", "12 000 Kč", true),
                _buildCard("Karel", "BMX", "12 000 Kč", true),
              ],
            ),
          ),

          //Buttony a jejich background

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

  Widget _buildCard(
    String autor,
    String nazev,
    String cena,
    bool vip,
  ) {
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
                  onTap: () {Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new ProductPage()),
            );},
                ),
                height: 240,
                fit: BoxFit.cover,
                padding: const EdgeInsets.all(50),
              ),

              //Název kola

              Positioned(
                left: 16,
                bottom: 32,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //buildBlur(
                    //  borderRadius: BorderRadius.circular(10),
                    //   child:
                    Container(
                      //   color: Colors.black.withOpacity(0.2),
                      //   padding: EdgeInsets.fromLTRB(5, 2, 5, 0),
                      child: Text(
                        nazev,
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
                    // ),
                    //buildBlur(
                    //borderRadius: BorderRadius.circular(10),
                    //child:
                    Container(
                      //   color: Colors.black.withOpacity(0.2),
                      //   padding: EdgeInsets.fromLTRB(5, 0, 5, 2),
                      child: Text(
                        autor,
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
                    // ),
                  ],
                ),
              ),

              //Jméno autora

              //Cena

              Positioned(
                right: 16,
                bottom: 32,
                //child: buildBlur(
                //borderRadius: BorderRadius.circular(20),
                child: Container(
                  //color: Colors.black.withOpacity(0.2),
                  //padding: EdgeInsets.all(5),
                  child: Text(
                    cena,
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
              //  ),
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
