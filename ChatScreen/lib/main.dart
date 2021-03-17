
import 'package:chat/theme.dart';
import 'package:flutter/material.dart';

import 'screens/messages/message_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: mainTheme(context),
      home: MessagesScreen(),
    );
  }
}
