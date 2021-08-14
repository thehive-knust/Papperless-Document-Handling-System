

import 'package:flutter/material.dart';

class EmailDetail extends StatefulWidget {
  const EmailDetail({Key? key}) : super(key: key);

  @override
  _EmailDetailState createState() => _EmailDetailState();
}

class _EmailDetailState extends State<EmailDetail> {

  TextEditingController? emailController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Container(
            padding: EdgeInsets.only(left: 25),
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: 'Enter Email',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    )),
                WidgetSpan(
                  child: Transform.translate(
                    offset: const Offset(2, -4),
                    child: Text(
                      '\*',
                      //superscript is usually smaller in size, you can change the size of it.
                      textScaleFactor: 1,
                      // you can change the color of your sign if you want.
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        Expanded(
          flex: 6,
          child: Container(
            margin: EdgeInsets.only(right: 200),
            padding: EdgeInsets.only(left: 20),
            child: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  filled: true,
                  hintText: 'thehive@knust.edu.gh',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w100,
                  ),
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide.none,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
