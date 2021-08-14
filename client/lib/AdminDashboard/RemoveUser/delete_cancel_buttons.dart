import 'package:flutter/material.dart';
import 'package:uis/RemoveUser/email_details.dart';

class CancelAdd extends StatefulWidget {
  @override
  _CancelAddState createState() => _CancelAddState();
}

class _CancelAddState extends State<CancelAdd> {
  void addUser() {
  }

  void cancelUser() {}

  @override
  Widget build(BuildContext context) {
    return Row(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: EdgeInsets.only(left: 20),
          child: ElevatedButton(
            onPressed: cancelUser,
            child: Text(
              "Cancel",
              style: TextStyle(fontSize: 18,
              color: Colors.black,
                fontWeight: FontWeight.w800
              ),
            ),
            style: ButtonStyle(
              shape:
                  ButtonStyleButton.allOrNull<OutlinedBorder>(StadiumBorder()),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
            ),
          ),
        ),
        SizedBox(
          width: 800,
        ),
        Container(
          margin: EdgeInsets.only(right: 50),
          child: ElevatedButton(
            onPressed: addUser,
            child: Text(
              "Delete",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            style: ButtonStyle(
              shape:
                  ButtonStyleButton.allOrNull<OutlinedBorder>(StadiumBorder()),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
