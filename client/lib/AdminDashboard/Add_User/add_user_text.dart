import 'package:flutter/material.dart';

class AddUserText extends StatelessWidget {
  const AddUserText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 30),
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          'Add User',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
  }
}
