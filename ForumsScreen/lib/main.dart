import 'package:flutter/material.dart';
import 'package:forums_screen/constants.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: kDarkTheme,
      child: Builder(builder: (context) {
        return MaterialApp(
          theme: ThemeProvider.of(context),
          debugShowCheckedModeBanner: false,
          home: MyHomePage(),
        );
      }),
    );
  }
}

double volume = 0;
PickedFile _imageFile;

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

  final ImagePicker _picker = ImagePicker();

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
      Navigator.of(context).pop();
    });
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 0,
            backgroundColor: Colors.black,
            title: Text(
              "Make a choice",
              style: kTitleTextStyle.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.green),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      "Gallery",
                      style: kTitleTextStyle,
                    ),
                    onTap: () {
                      takePhoto(ImageSource.gallery);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(16)),
                  GestureDetector(
                    child: Text(
                      "Camera",
                      style: kTitleTextStyle,
                    ),
                    onTap: () {
                      takePhoto(ImageSource.camera);
                    },
                  )
                ],
              ),
            ),
          );
        });
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Scaffold(
            body: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                _NewPost(
                  datum: "10.4.2020",
                  user: "Karel",
                  nadpis: "Tady by byl Nadpis",
                  text: "Tady by byl tex toho postu",
                  isImage: false,
                ),
                _NewPost(
                  datum: "10.4.2020",
                  user: "Karel",
                  nadpis: "Tady by byl Nadpis",
                  text: "Tady by byl tex toho postu",
                  isImage: false,
                ),
              ],
            ),
          ),
          IgnorePointer(
            ignoring: animationController.isCompleted ? false : true,
            child: Container(
              color: Colors.black.withOpacity(volume),
            ),
          ),
          //Button
          Stack(
            children: <Widget>[
              Positioned(
                  right: 30,
                  bottom: 30,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: <Widget>[
                      IgnorePointer(
                        child: Container(
                          color: Colors.transparent,
                          height: 150,
                          width: 150,
                        ),
                      ),
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
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onClick: () {
                              Navigator.pop(context);
                            },
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
                              Icons.add_comment,
                              color: Colors.white,
                            ),
                            onClick: () {},
                          ),
                        ),
                      ),
                      /*Transform.translate(
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
                      ),*/
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
}

class _NewPost extends StatefulWidget {
  final String datum;
  final String nadpis;
  final String text;
  final String user;

  bool isImage;

  _NewPost({this.datum, this.nadpis, this.text, this.user, this.isImage,});

  @override
  __NewPostState createState() => __NewPostState();
}

class __NewPostState extends State<_NewPost> {
  bool liked = false;
  bool disliked = false;

  _pressed_like() {
    setState(() {
      liked = !liked;
            if(disliked==true){
        liked=false;
      }
    });
  }

  _pressed_dislike() {
    setState(() {
      disliked = !disliked;
      if(liked==true){
        disliked=false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //Info o uživateli
    var profileInfo = Container(
      color: Colors.transparent,
      height: size.height * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            radius: size.height * 0.03,
            backgroundImage: NetworkImage(
                "https://www.surforma.com/media/filer_public_thumbnails/filer_public/4b/00/4b007d44-3443-4338-ada5-47d0b99db7ad/l167.jpg__800x600_q95_crop_subsampling-2_upscale.jpg"),
            child: Icon(
              FontAwesomeIcons.user,
              color: Colors.white,
              size: size.height * 0.03,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.user,
                style: kTitleTextStyle,
              ),
              SizedBox(height: 2),
              //Text('karelfrajer@gmail.com',style: kCaptionTextStyle,),
            ],
          )
        ],
      ),
    );

    var postInfo = Container(
      height: size.height * 0.08,
      width: size.width * 0.95,
      color: Colors.black45,
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          profileInfo,
          Row(
            children: [
              Text(
                widget.datum,
                style: kCaptionTextStyle,
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
    );

    return Center(
      child:

          //rámeček postu
          Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: size.width * 0.95,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Info o uživateli a datum postnutí
                postInfo,
                //Obsah postu
                Container(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 15),
                        width: size.width * 0.95,
                        child: Text(
                          widget.nadpis,
                          style: kTitleTextStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                        width: size.width * 0.95,
                        child: Text(
                          widget.text,
                          style: TextStyle(fontSize: 18),
                          maxLines: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                //Řádek na like/dislike a koment
                Container(
                  height: size.height * 0.10,
                  color: Colors.black45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 40,
                          ),
                          Icon(
                            FontAwesomeIcons.comment,
                            size: size.height * 0.04,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              liked
                                  ? Icons.thumb_up_rounded
                                  : Icons.thumb_up_alt_outlined,
                                  size: size.height * 0.052,
                            ),
                            color: liked ? Colors.green : Colors.white,
                            onPressed: () => _pressed_like(),
                          ),
                          
                          SizedBox(
                            width: 25,
                          
                          ),
                        
                          IconButton(
                            icon: Icon(
                              disliked
                                  ? Icons.thumb_down_rounded
                                  : Icons.thumb_down_alt_outlined,
                              size: size.height * 0.052,
                            ),
                            color: disliked ? Colors.green : Colors.white,
                            onPressed: () => _pressed_dislike(),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
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
