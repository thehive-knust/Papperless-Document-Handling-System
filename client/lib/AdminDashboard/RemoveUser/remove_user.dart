import 'package:flutter/material.dart';
import 'package:uis/RemoveUser/delete_cancel_buttons.dart';
import 'package:uis/RemoveUser/remove_user_text.dart';
import 'package:uis/RemoveUser/association.dart';
import 'package:uis/RemoveUser/email_details.dart';
import 'package:uis/RemoveUser/name_details.dart';

class Removeuser extends StatefulWidget {
  @override
  _RemoveuserState createState() => _RemoveuserState();
}

class _RemoveuserState extends State<Removeuser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RemoveUserText(),
          //Spacer(),
          SizedBox(height: 40,),
          Expanded(
            flex: 3,
            child: EmailDetail(),
          ),
          Expanded(
            flex: 3,
            child: NameDetails(),
          ),
          // SizedBox(height: 10,),
          Expanded(
            flex: 6,
            child: Association(),
          ),
          Expanded(
            flex: 4,
            child: CancelAdd(),
          ),
        ],
      ),
    );
  }
}
