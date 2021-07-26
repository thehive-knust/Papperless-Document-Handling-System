import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
// import 'package:softdoc/utills.dart';

class FlaskDatabase {
  // -TODO: upload document:------------------------------

// -TODO: download document:----------------------------

// -TODO: authentication:-------------------------------
  static Future<bool> authenticate({String userId, String password}) async {
    Uri url = Uri.parse("https://soft-doc.herokuapp.com/users/login");
    http.Response response;
    try {
      response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // "Accept": "application/json",
          // "Access-Control_Allow_Origin": "*"
        },
        body: jsonEncode(
          <String, String>{'user_id': userId, 'password': password},
        ),
      );

      if (response.statusCode == 200) {
        print(response.body);
        return true;
      } else {
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      print("This is the Error Message => " + e.toString());
    }
  }

// test get request:-----------------------
  static Future<http.Response> getMessage() async {
    http.Response response;

    try {
      response = await http.get(
        Uri.parse('http://192.168.138.29:5000/user/'),
      );
    } catch (e) {
      print("=======" + e.toString() + "------------");
    }
    if (response.statusCode == 200) {
      print(response.body);
      jsonDecode("source");
    }
    return response;
  }

  // test local network:------------------------------------
  static Future getLocal() async {
    http.Response response;
    try {
      response = await http.get(
        Uri.parse('https://soft-doc.herokuapp.com/'),
      );
    } catch (e) {
      debugPrint("---------" + e.toString() + "------------");
    }
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
