import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chart.dart';

class AdminUser extends StatefulWidget {
  const AdminUser({Key? key}) : super(key: key);

  @override
  _AdminUserState createState() => _AdminUserState();
}

class _AdminUserState extends State<AdminUser> {
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
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    hintText: "Search",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w100,
                    ),
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
              icon: Icon(Icons.notifications),
              color: Colors.black,
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.email),
              color: Colors.black,
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings),
              color: Colors.black,
            ),
          ),
        ],
      ),
      drawer: Container(
        child: Drawer(
          elevation: 20,
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.only(top: 15),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[500],
                  child: Icon(Icons.person),
                  radius: 80,
                ),
              ),
              Divider(
                thickness: 3,
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "User Name",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(110, 5, 110, 50),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  style: ButtonStyle(
                    shape: ButtonStyleButton.allOrNull<OutlinedBorder>(
                        StadiumBorder()),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.lightBlue),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                highlightColor: Colors.green,
                customBorder: StadiumBorder(),
                child: ListTile(
                  leading: Icon(
                    Icons.person_add,
                    color: Colors.green,
                    size: 30,
                  ),
                  title: Text(
                    "Add User",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                highlightColor: Colors.red,
                customBorder: StadiumBorder(),
                child: ListTile(
                  leading: Icon(
                    Icons.person_remove_alt_1,
                    color: Colors.red,
                    size: 30,
                  ),
                  title: Text(
                    "Remove User",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(120, 5, 120, 2),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      //margin: EdgeInsets.all(20),
                      width: 150,
                      height: 140,
                      color: Colors.blue,
                      child: Card(
                        color: Colors.blueAccent,
                        child: ListTile(
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.person,
                                size: 70,
                                color: Colors.white,
                              ),
                              VerticalDivider(
                                thickness: 1.5,
                              )
                            ],
                          ),
                          title: Text(
                            "Total Users",
                            style: TextStyle(fontSize: 25),
                          ),
                          subtitle: Text("2345",
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.red)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: 150,
                      height: 140,
                      //margin: EdgeInsets.all(20),
                      //color: Colors.blue,
                      child: Card(
                        color: Colors.blueAccent,
                        child: ListTile(
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.person,
                                size: 70,
                                color: Colors.blue,
                              ),
                              VerticalDivider(
                                thickness: 1.5,
                              )
                            ],
                          ),
                          title: Text(
                            "Total Student Users",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          subtitle: Text("1245",
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.lightBlue)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: 150,
                      height: 140,
                      //color: Colors.blue,
                      //margin: EdgeInsets.all(20),
                      child: Card(
                        color: Colors.blueAccent,
                        child: ListTile(
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.person,
                                size: 70,
                              ),
                              VerticalDivider(
                                thickness: 1.5,
                              )
                            ],
                          ),
                          title: Text(
                            "Total Staff Users",
                            style: TextStyle(fontSize: 25),
                          ),
                          subtitle: Text("1345",
                              style:
                                  TextStyle(fontSize: 35, color: Colors.green)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Chart(),
            ),
          ],
        ),
      ),
    );
  }
}
