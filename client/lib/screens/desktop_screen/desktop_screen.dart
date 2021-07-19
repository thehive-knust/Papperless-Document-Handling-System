import 'package:flutter/material.dart';
import 'package:softdoc/screens/detail_screen/detail_screen.dart';
import 'package:softdoc/screens/home_screen/home_screen.dart';
import 'package:softdoc/screens/send_doc_screen/add_or_edit_recepient.dart';
import 'package:softdoc/screens/send_doc_screen/select_recepient.dart';
import 'package:softdoc/screens/send_doc_screen/send_doc_screen.dart';

class DesktopScreen extends StatefulWidget {
  const DesktopScreen({Key key}) : super(key: key);

  @override
  _DesktopScreenState createState() => _DesktopScreenState();
}

class _DesktopScreenState extends State<DesktopScreen> {
  void changeState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: [
          Container(
            height: double.infinity,
            width: screenSize.width * 0.33,
            child: HomeScreen(),
          ),
          Expanded(
            // height: double.infinity,
            // width: screenSize.width * 0.35,
            child: Row(
              children: [
                Expanded(child: SendDocScreen(isDesktop: true)),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 12, right: 10, bottom: 10),
                    child: Column(
                      children: [
                        addOrEditReciepient(true, changeState),
                        SizedBox(height: 10),
                        Expanded(child: selectRecepient(changeState))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
