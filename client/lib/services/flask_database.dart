import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:softdoc/models/doc.dart';
import 'package:softdoc/models/user.dart';
// import 'package:softdoc/utills.dart';

class FlaskDatabase {
  static const GET_DEPT_URL = "https://soft-doc.herokuapp.com/departments/get/";
  static const GET_USERS_IN_DEPT_URL =
      "https://soft-doc.herokuapp.com/departments/users/";
  static const GET_SENTDOCS_URL =
      "https://soft-doc.herokuapp.com/documents/user/";
  static const GET_RECEIVEDDOCS_URL =
      "https://soft-doc.herokuapp.com/documents/new/";

  // -TODO: authentication:-------------------------------
  static Future<Map> authenticateWithIdAndPassword(
      String userId, String password) async {
    print('==================================check this out');
    print("$userId $password");
    Uri url = Uri.parse("https://soft-doc.herokuapp.com/auth/login");
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
        print(response.body);
        return jsonDecode(response.body);
      } else {
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      print("authentication Error Message => " + e.toString());
      return null;
    }
  }

  static dynamic getApi(url) async {
    http.Response response;
    try {
      response = await http.get(
        Uri.parse(url),
        // headers: <String, String>{'access_token': 'the_access_token'}
      );

      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      } else {
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      print("get Api error => " + e.toString());
      return null;
    }
  }

  //TODO: implement get departments here:
  static Future<dynamic> getDepartmentsByColId(colId) async =>
      getApi(GET_DEPT_URL + colId);

  //TODO: implement get users in deparment here:
  static Future<dynamic> getUsersInDepartmentByDeptId(deptId) async =>
      getApi(GET_USERS_IN_DEPT_URL + deptId);

  //TODO: implement get sent docs here:
  static Future<dynamic> getSentDocsByUserId(userId) async =>
      getApi(GET_SENTDOCS_URL + userId);

  //TODO: implement get received docs here:
  static Future<dynamic> getReceivedDocsByUserId(userId) async =>
      getApi(GET_RECEIVEDDOCS_URL + userId);

  //TODO: implement post document:--------------
  static Future<bool> sendDoc(Doc doc) async {
    Uri uri = Uri.parse("https://soft-doc.herokuapp.com/documents/upload");
    http.MultipartRequest request;
    http.StreamedResponse response;
    try {
      request = http.MultipartRequest("POST", uri);
      request.fields.addAll(Map<String, String>.from(doc.toMap()));
      request.files.add(http.MultipartFile.fromBytes(
          'file', doc.fileBytes.toList(),
          filename: doc.filename));
      // request.headers
      //     .addAll(<String, String>{'access_token': 'the_access_token'});

      response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      print("send doc Error Message => " + e.toString());
      return false;
    }
  }

  //TODO: implement approval stuff here:--------
  static Future<bool> sendApproval(recipientId, docId, status) async {
    Uri uri = Uri.parse("https://soft-doc.herokuapp.com/approvals/update");
    http.Response response;
    try {
      response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // 'access_token': 'the_access_token'
        },
        body: jsonEncode(
          <String, String>{
            'user_id': recipientId,
            'doc_id': docId,
            'status': status
          },
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
      print("send approval Error Message => " + e.toString());
      return false;
    }
  }

  static Future<bool> delectDocumentByDocumentId(docId) async {
    Uri uri = Uri.parse(
        "https://soft-doc.herokuapp.com/documents/delete/${int.parse(docId)}");
    http.Response response;
    try {
      response = await http.delete(
        uri,
        // headers: <String, String>{'access_token': 'the_acces_token'}
      );

      if (response.statusCode == 200) {
        print(response.body);
        return true;
      } else {
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      print("delete document Error Message => " + e.toString());
      return false;
    }
  }
}
