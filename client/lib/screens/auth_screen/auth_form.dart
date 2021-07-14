import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:softdoc/style.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class AuthForm extends StatelessWidget {
  final bool isDesktop;
  AuthForm({Key key, this.isDesktop}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  String id;
  String testPass;
  Digest password;

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment:
            isDesktop ? MainAxisAlignment.center : MainAxisAlignment.start,
        crossAxisAlignment:
            isDesktop ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            "SoftDoc",
            style: TextStyle(
              fontSize: 37,
              fontWeight: FontWeight.w600,
            ),
          ),
          isDesktop ? SizedBox(height: 10) : const SizedBox(height: 40),
          TextFormField(
            onChanged: (newId) {
              id = newId;
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
              // List<int> bytes = utf8.encode(pass);
              // password = sha512.convert(bytes);
              testPass = pass;
            },
            validator: (pass) => pass.isEmpty ? "Please enter password" : null,
            obscureText: true,
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
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              )),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  // print("==============================");
                  // print("the id is: " +
                  //     id.toString() +
                  //     " and the password is: $password");
                  try {
                    Uri uri = Uri.parse("https://soft-doc.herokuapp.com/users/login");
                    http.Response respond = await http.get(uri);
                    print(respond.body);
                    http.Response response = await http.post(uri,
                        headers: <String, String>{
                          // 'Content-Type': 'application/json; charset=UTF-8',
                          "Accept": "application/json",
                          "Access-Control_Allow_Origin": "*"
                        },
                        body: jsonEncode(<String, String>{
                          'user_id': id,
                          'password': testPass
                        }));
                    print("================================================");
                    if (response.statusCode == 200) {
                      print(jsonDecode(response.body));
                    } else {
                      print(response.statusCode);
                    }
                    print("================================================");
                  } catch (e) {
                    print("=========================================");
                    print("This is the Error Message" + e.toString());
                  }
                }
              },
              child: Text("Verify", style: TextStyle(fontSize: 20)),
            ),
          )
        ],
      ),
    );
  }
}
