import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letbike/account/accountSettings.dart';
import 'package:letbike/filters/filters.dart';
import 'package:letbike/article/articlePage.dart';
import 'package:letbike/article/articlesScreen.dart';
import 'package:letbike/sign/forgot.dart';
import 'package:letbike/sign/register.dart';
import 'package:letbike/sign/login.dart';
import 'package:letbike/item/itemPage.dart';
import 'package:letbike/item/addItem.dart';
import 'package:letbike/app/homePage.dart';
import 'package:letbike/chat/chatScreen.dart';
import 'package:letbike/account/accountScreen.dart';
import 'package:letbike/account/accountChangePass.dart';

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
        ArticlesScreen.routeName: (context) => ArticlesScreen(),
        ArticlePage.routeName: (context) => ArticlePage(),
        FilterPage.routeName: (context) => FilterPage(),
      },
    );
  }
}
