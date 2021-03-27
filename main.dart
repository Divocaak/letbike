import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letbike/account/accountSettings.dart';
import 'package:letbike/app/filterPage.dart';
import 'sign/screens.dart';
import 'app/homePage.dart';
import 'app/itemPage.dart';
import 'chat/chatScreen.dart';
import 'account/accountScreen.dart';
import 'account/accountSettings.dart';
import 'account/accountChangePass.dart';
import 'addItem/addItem.dart';

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
        ChatScreen.routeName: (content) => ChatScreen(),
        AccountScreen.routeName: (context) => AccountScreen(),
        AccountSettings.routeName: (context) => AccountSettings(),
        ChangePassword.routeName: (context) => ChangePassword(),
        AddItem.routeName: (context) => AddItem(),
        FilterPage.routeName: (context) => FilterPage(),
      },
    );
  }
}
