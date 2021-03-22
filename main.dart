import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sign/screens.dart';
import 'app/homePage.dart';
import 'app/itemPage.dart';
import 'chat/chatScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LetBike',
      theme: ThemeData(
        textTheme:
            GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => LoginScreen(),
        "ForgotPassword": (context) => ForgotPassword(),
        "CreateNewAccount": (context) => CreateNewAccount(),
        HomePage.routeName: (context) => HomePage(),
        ItemPage.routeName: (context) => ItemPage(),
        ChatScreen.routeName: (content) => ChatScreen()
      },
    );
  }
}
