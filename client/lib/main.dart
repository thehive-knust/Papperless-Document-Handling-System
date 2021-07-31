
import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
      //   HOMEPAGE : (context) => PlatformSelect(),
      //   DETAILPAGE: (context) => DetailScreen(),
      //   SENDPAGE: (context) => SendDocScreen(),
      //   DESKTOPAUTHPAGE: (context) => DesktopAuthScreen(),
      //   AUTHPAGE: (context) => AuthScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
