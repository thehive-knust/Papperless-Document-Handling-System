import 'package:flutter/material.dart';
import 'package:softdoc/screens/auth_screen/auth_form.dart';

class DesktopAuthScreen extends StatelessWidget {
  const DesktopAuthScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/auth_desktop_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: screenSize.width * 0.25,
              margin: EdgeInsets.only(right: 90),
              child: AuthForm(isDesktop: true),
            ),
          ],
        ),
      ),
    );
  }
}
