import 'package:flutter/material.dart';

class RemoveUserText extends StatelessWidget {
  const RemoveUserText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 30),
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          'Remove User',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
  }
}
