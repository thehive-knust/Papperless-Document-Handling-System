import 'package:admin_screen/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;
    return Container(
      decoration: isDesktop?BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/auth_desktop_background.png'),
          fit: BoxFit.fill,
        ),
      ):null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(minWidth: 250),
            width: isDesktop?MediaQuery.of(context).size.width *0.3:MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
              right: isDesktop ? 70 : 0,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: AuthForm(isDesktop),
          ),
        ],
      ),
    );
  }
}
