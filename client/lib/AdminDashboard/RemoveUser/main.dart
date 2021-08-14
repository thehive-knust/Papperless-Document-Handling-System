import 'package:flutter/material.dart';
import '../AdminUser/AdminUser.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdminUser(),
      // color: Colors.blue,
    );
  }
}
