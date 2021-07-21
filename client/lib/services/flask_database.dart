import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

// -TODO: upload document:------------------------------

// -TODO: download document:----------------------------

// -TODO: authentication:-------------------------------
Future<http.Response> authenticate({String userId, String password}) async {
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

    print(response.body);
  } catch (e) {
    print("=========================================");
    print("This is the Error Message " + e.toString());
  }
  print("================================================");
  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
  } else {
    print(response.statusCode);
  }
  print("================================================");
  return response;
}

// test get request:-----------------------
Future<http.Response> getMessage() async {
  print("-------im running");
  http.Response response;
  Uri uri;

  try {
    uri = Uri.parse("http://soft-doc.herokuapp.com/");
    response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body);
    }
  } on PlatformException catch (e) {
    print("------" + e.toString() + "--------");
  }
  return response;
}
