import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Api {
  static const index = "https://soft-doc.herokuapp.com/";

  static Future<List<dynamic>?> fetchUsers() async {
    final List<dynamic>? users;
    try {
      final response = await http
          .get(Uri.parse(index + 'users/'))
          .timeout(const Duration(seconds: 30));
      users = jsonDecode(response.body)['users'];
      print("===========users");
      print(users);
      return users;
    } on TimeoutException {
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> deleteUser(BuildContext context, String id) async {
    try {
      final response = await http.post(Uri.parse(index + "users/delete/" + id));
      Navigator.of(context).pop();
      return response.statusCode == 200;
    } catch (e) {
      Navigator.of(context).pop();
      return false;
    }
  }

  static Future<bool> editUserAttributes(
      context, oldId, Map<String, String> newAttributes) async {
    print("===========new attributes in api call");
    print(newAttributes);
    try {
      final response = await http.post(
        Uri.parse(index + "users/update/" + oldId),
        body: jsonEncode(newAttributes),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      Navigator.of(context).pop();
      print("===========status code");
      print(response.statusCode);
      return response.statusCode == 200;
    } catch (e) {
      Navigator.of(context).pop();
      return false;
    }
  }

  static Future<dynamic> fetchCategory(String category) async {
    final String extension;
    switch (category) {
      case "portfolios":
        extension = category;
        break;
      case "faculties":
        extension = category + "/college/COE";
        break;
      case "departments":
        extension = category + "/get/COE";
        break;
      default:
        extension = "";
    }

    try {
      final response = await http.get(Uri.parse(index + extension));
      if (response.statusCode == 200)
        return jsonDecode(response.body);
      else
        return null;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> login(userId, password) async {
    Uri url = Uri.parse(index + "auth/login");
    http.Response response;
    try {
      response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{'id': userId, 'password': password},
        ),
      );

      if (response.statusCode == 200) {
        return false;
      } else {
        print(response.statusCode);
        return true;
      }
    } catch (e) {
      print("authentication Error Message => " + e.toString());
      return true;
    }
  }
}
