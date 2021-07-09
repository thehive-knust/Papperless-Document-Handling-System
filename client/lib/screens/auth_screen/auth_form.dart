import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:softdoc/style.dart';
import 'package:http/http.dart' as http;

class AuthForm extends StatelessWidget {
  AuthForm({Key key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  int id;
  String password;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width * 0.25,
      margin: EdgeInsets.only(right: 90),
      color: Colors.pink,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SoftDoc",
              style: TextStyle(
                fontSize: 37,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              onChanged: (newId) {
                id = int.parse(newId);
              },
              validator: (newId) =>
                  newId.isEmpty ? "please enter ID number" : null,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: primaryLight,
                hintText: "Enter your ID number",
                hoverColor: primary.withOpacity(.15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              onChanged: (pass) {
                password = pass;
              },
              validator: (pass) =>
                  pass.isEmpty ? "Please enter password" : null,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                filled: true,
                fillColor: primaryLight,
                hintText: "password",
                hoverColor: primary.withOpacity(.15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: 45,
              width: double.infinity * 0.2,
              // margin: EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    Uri uri = Uri.parse('192.168.43.205:5000/users/login');
                    http.Response response = await http
                        .post(uri, body: {'id': id, 'password': password});

                    if (response.statusCode == 200) {
                      print(jsonDecode(response.body));
                    } else {
                      print(response.statusCode);
                    }
                  }
                },
                child: Text("Verify", style: TextStyle(fontSize: 20)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
