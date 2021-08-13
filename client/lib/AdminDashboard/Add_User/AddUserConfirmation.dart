
import 'package:flutter/material.dart';

//Add User Confirmation Message

class AddUserConfirmation extends StatefulWidget {
  const AddUserConfirmation({Key? key}) : super(key: key);

  @override
  _AddUserConfirmationState createState() => _AddUserConfirmationState();
}

class _AddUserConfirmationState extends State<AddUserConfirmation> {
  void ok(){

  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body:

      Container(
        alignment: Alignment.center,
        child: Container(
          height: 90,
          width: 380,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Icon(Icons.check_box,
              color: Colors.black,),

              // Message to display after adding a new user

              Text("You have successfully added a new user"
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
                    onPressed: ok,
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
