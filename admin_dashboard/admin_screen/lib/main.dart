import 'package:admin_screen/AdminUser.dart';
import 'package:admin_screen/add_user.dart';
import 'package:flutter/material.dart';

void main()=>runApp(HomePage());

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Adduser(),
    );
  }
}
