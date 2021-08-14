import 'package:flutter/material.dart';

import 'add_user_text.dart';




class Adduser extends StatefulWidget {
  @override
  _AdduserState createState() => _AdduserState();
}

class _AdduserState extends State<Adduser> {
  int? radioValue = 1;
  TextEditingController? associationRoleController;
  void changeRadioButtonValue(int? value) {
    setState(() {
      radioValue = value;
    });
  }

  TextEditingController? emailController;
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? otherNameController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AddUserText(),
          //Spacer(),
          SizedBox(height: 40,),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20),
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
                  flex: 2,
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
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
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
                Spacer(flex: 2,),

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
            ),
          ),
          // SizedBox(height: 10,),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Association Role",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          margin: const EdgeInsets.only(right: 700.0),
                          padding: const EdgeInsets.only(left: 20),
                          child: TextField(
                            controller: associationRoleController,
                            decoration: InputDecoration(
                                filled: true,
                                hintText: ' Association Role',
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
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.only(left: 20),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Access Right',
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
                              style: TextStyle(color: Colors.red, fontSize: 20),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: ListTile(
                          title: Text("Standard User"),
                          leading: Radio(
                            value: 1,
                            groupValue: radioValue,
                            onChanged: changeRadioButtonValue,
                            activeColor: Colors.green,
                          ),
                        ),),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        flex: 6,
                        child: ListTile(
                          title: Text("Admin User"),
                          leading: Radio(
                            value: 2,
                            groupValue: radioValue,
                            onChanged: changeRadioButtonValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20),
                child: ElevatedButton(
                  onPressed: (){

                  },
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
                  onPressed: (){

                  },
                  child: Text(
                    "Add User",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  style: ButtonStyle(
                    shape:
                    ButtonStyleButton.allOrNull<OutlinedBorder>(StadiumBorder()),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                  ),
                ),
              ),
            ],
          ),
          ),
        ],
      ),
    );
  }
}
