import 'package:flutter/material.dart';
import 'package:softdoc/screens/auth_screen/auth_screen.dart';
import 'package:softdoc/screens/desktop_screen/desktop_auth_screen.dart';
import 'package:softdoc/screens/desktop_screen/desktop_screen.dart';
import 'package:softdoc/screens/home_screen/home_screen.dart';

class PlatformSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = false;
    bool isDesktop = MediaQuery.of(context).size.width > 500;
    if(isDesktop){
      return isLoggedIn ? DesktopScreen() : DesktopAuthScreen();
    } else {
      return isLoggedIn ? HomeScreen() : AuthScreen();
    }
  }
}
