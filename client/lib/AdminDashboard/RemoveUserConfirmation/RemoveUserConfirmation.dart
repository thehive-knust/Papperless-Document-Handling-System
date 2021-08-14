
import 'package:flutter/material.dart';

class RemoveUserConfirmation extends StatefulWidget {
  const RemoveUserConfirmation({Key? key}) : super(key: key);

  @override
  _RemoveUserConfirmationState createState() => _RemoveUserConfirmationState();
}

class _RemoveUserConfirmationState extends State<RemoveUserConfirmation> {
 void ok(){

 }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body:

      Container(
        alignment: Alignment.center,
        child: Container(
          height: 100,
          width: 430,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Icon(Icons.check_box,
              color: Colors.black,),

              Text("You have successfully removed an existing user"
              ,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold

                ),
              ),
              SizedBox(height: 2),
              Container(
                  padding: EdgeInsets.only(left: 20),
                  child: ElevatedButton(
                    onPressed:ok,
                    child: Text(
                      "OK",
                      style: TextStyle(fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w800
                      ),
                    ),
                    style: ButtonStyle(
                      shape:
                      ButtonStyleButton.allOrNull<OutlinedBorder>(StadiumBorder()),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black12,
    );

  }
}
