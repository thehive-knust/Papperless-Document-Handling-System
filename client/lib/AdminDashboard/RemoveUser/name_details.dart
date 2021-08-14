import 'dart:io';

import 'package:flutter/material.dart';

class NameDetails extends StatefulWidget {
  const NameDetails({Key? key}) : super(key: key);

  @override
  _NameDetailsState createState() => _NameDetailsState();
}

class _NameDetailsState extends State<NameDetails> {
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? otherNameController;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.only(left: 20.0),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'First Name',
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
          ),

        Expanded(
          flex: 7,
          child: Container(
            padding: const EdgeInsets.only(left: 5.0),
            child: TextField(
              controller: firstNameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  filled: true,
                  hintText: 'First Name',
                  hintStyle: TextStyle(
                    fontSize: 15,
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
        Spacer(flex: 3,),

        Expanded(
          flex: 3,
          child: Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Last Name',
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
        ),
        Expanded(
          flex: 7,
          child: Container(
            //margin: EdgeInsets.only(right: 20),
            padding: const EdgeInsets.only(left: 5.0),
            child: TextField(
              controller: lastNameController,
              decoration: InputDecoration(
                  filled: true,
                  hintText: 'Last Name',
                  hintStyle: TextStyle(
                    fontSize: 20,
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
        Spacer(flex: 2,),
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.only(left: 5.0),
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: 'Other Name(s)',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    )),
              ]),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            margin: EdgeInsets.only(right: 5),
            padding: const EdgeInsets.only(left: 5.0),
            child: TextField(
              controller: otherNameController,
              decoration: InputDecoration(
                  filled: true,
                  hintText: 'Other Name(s)',
                  hintStyle: TextStyle(
                    fontSize: 20,
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
