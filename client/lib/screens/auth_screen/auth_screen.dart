import 'package:flutter/material.dart';
import 'package:softdoc/screens/auth_screen/auth_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: 450,
        width: double.infinity,
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.only(top: 70),
        // color: Colors.green,
        child: AuthForm(isDesktop: false),
      ),
    );
  }
}
