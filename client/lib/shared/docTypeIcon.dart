import 'package:flutter/material.dart';

class DocTypeIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      alignment: Alignment.center,
      height: 35,
      width: 35,
      child: Text('PDF',
          style: TextStyle(fontSize: 13, color: Colors.black54)),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(7),
      ),
    );
  }
}
