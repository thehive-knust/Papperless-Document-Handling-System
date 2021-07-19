import 'package:flutter/material.dart';
import 'package:softdoc/screens/home_screen/home_screen.dart';
import 'package:softdoc/screens/send_doc_screen/send_doc_screen.dart';

class DesktopScreen extends StatelessWidget {
  const DesktopScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Row(
      children: [
        Container(
            constraints: BoxConstraints(
              minWidth: 400,
            ),
            height: double.infinity,
            width: screenSize.width * 0.35,
            child: HomeScreen()),
        Container(
          height: double.infinity,
          width: screenSize.width - 500,
          child: SendDocScreen(isDesktop: true),
        )
      ],
    ));
  }
}
