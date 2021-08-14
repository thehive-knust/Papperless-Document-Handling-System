import 'package:flutter/material.dart';
import 'package:uis/AddUserConfirmation/AddUserConfirmation.dart';
import 'package:uis/AdminUser/AdminUser.dart';
import 'package:uis/RemoveUserConfirmation/RemoveUserConfirmation.dart';
import 'remove_user.dart';

void main()=>runApp(Home());

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdminUser(),
      // color: Colors.blue,
    );
  }
}