import 'dart:core';

import 'package:admin_screen/add_user.dart';
import 'package:admin_screen/display_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';




class AdminUser extends StatefulWidget {
  const AdminUser({Key? key}) : super(key: key);

  @override
  _AdminUserState createState() => _AdminUserState();
}


class _AdminUserState extends State<AdminUser> {
  
  void addUserScreen(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return Adduser();
    }));
  }
  
  
GlobalKey<ScaffoldState>? _scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[600],
        actions: [
          Spacer(
            flex: 2,
          ),
          Expanded(
            flex: 15,
            child: Container(
              width: 900,
              height: 5,
              margin: EdgeInsets.fromLTRB(10, 10, 50, 5),
              child: TextField(
                cursorColor: Colors.black,
                cursorHeight: 25,
                cursorWidth: 3.2,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    hintText: "Search",
                    hintStyle: GoogleFonts.notoSans(),
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide.none,
                    )),
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {},
              hoverColor: Colors.black38,
              splashRadius: 20,
              icon: Icon(Icons.notifications),
              tooltip: "Notification",
              color: Colors.black,
            ),
          ),
        ],
      ),
      drawer:
      Container(
        child: Drawer(
          elevation: 20,
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(5, 10, 140, 10),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[500],
                  child: Icon(Icons.person),
                  radius: 50,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(50, 0, 140, 5),
                child: Text(
                  "User Name",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.notoSans()
                ),
              ),
              Divider(thickness: 0.5,),
              Container(
                child: InkWell(
                  onTap: (){

                  },
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text("Profile"),
                  ),
                ),
              ),
              Container(
                child: InkWell(
                  onTap: (){

                  },
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Settings"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),


      body: Container(
        padding: EdgeInsets.fromLTRB(100, 50, 0, 50),
          child: Display(),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          addUserScreen(context);
        },
        child: Icon(Icons.add, size: 35,),
      ),
    );
  }
}