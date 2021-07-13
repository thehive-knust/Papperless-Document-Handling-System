import 'package:flutter/material.dart';
import 'package:softdoc/screens/auth_screen/auth_screen.dart';
import 'package:softdoc/screens/desktop_screen/desktop_auth_screen.dart';
import 'package:softdoc/screens/detail_screen/detail_screen.dart';
import 'package:softdoc/screens/home_screen/home_screen.dart';
import 'package:softdoc/screens/send_doc_screen/send_doc_screen.dart';
import 'style.dart';
// import 'package:softdoc/screens/home_screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HOMEPAGE : (context) => SendDocScreen(),// AuthScreen(),
        DETAILPAGE: (context) => DetailScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
