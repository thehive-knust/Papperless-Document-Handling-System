import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Api {
  static const index = "https://soft-doc.herokuapp.com/";

  static Future<List<dynamic>?> fetchUsers() async {
    final List<dynamic>? users;
    try {
      print(
          "===========================Before Users============================");
      final response = await http
          .get(Uri.parse(index + 'users/'))
          .timeout(const Duration(seconds: 30));
      users = jsonDecode(response.body)['users'];
      print("===========================Users============================");
      print(users);
      return users;
    } on TimeoutException {
      print(
          '=================================Timeout============================');
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool> deleteUser(BuildContext context, String id) async {
    try {
      print(id);
      final response = await http.post(Uri.parse(index + "users/delete/" + id));
      print(response.statusCode);
      Navigator.of(context).pop();
      return response.statusCode == 200;
    } catch (e) {
      Navigator.of(context).pop();
      return false;
    }
  }

  static Future<bool> editUserAttributes(
      context, oldId, Map<String, String> newAttributes) async {
    try {
      print(
          '===============================is this doing anything======================');
      print(oldId);
      print(newAttributes);
      final response = await http.post(
        Uri.parse(index + "users/update/" + oldId),
        body: jsonEncode(newAttributes),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      Navigator.of(context).pop();
      print(response.statusCode);
      return response.statusCode == 200;
    } catch (e) {
      print('=========================ERROR=======================');
      print(e);

      Navigator.of(context).pop();
      return false;
    }
  }
}
