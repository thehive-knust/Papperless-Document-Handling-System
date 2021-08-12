import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:softdoc/models/doc.dart';
import 'package:softdoc/models/user.dart';
// import 'package:softdoc/utills.dart';

class FlaskDatabase {
  // -TODO: authentication:-------------------------------
  static Future<Map> authenticateWithIdAndPassword(
      String userId, String password) async {
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

  // test get request:-----------------------
  // static Future<http.Response> getMessage() async {
  //   http.Response response;

  //   try {
  //     response = await http.get(
  //       Uri.parse('http://192.168.138.29:5000/user/'),
  //     );
  //   } catch (e) {
  //     print("=======" + e.toString() + "------------");
  //   }
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     // jsonDecode("source");
  //   }
  //   return response;
  // }

  // test local network:------------------------------------
  // static Future getLocal() async {
  //   http.Response response;
  //   try {
  //     response = await http.get(
  //       Uri.parse('https://soft-doc.herokuapp.com/'),
  //     );
  //   } catch (e) {
  //     debugPrint("---------" + e.toString() + "------------");
  //   }
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //   } else {
  //     print(response.statusCode);
  //   }
  // }

  //TODO: implement get departments here:
  static Future<dynamic> getDepartmentsByColId(colId) async {
    Uri url = Uri.parse(
        "https://soft-doc.herokuapp.com/departments/get/${int.parse(colId)}");
    http.Response response;
    try {
      response = await http.get(url);

      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      } else {
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      print("get departments error message => " + e.toString());
      return null;
    }
  }

  //TODO: implement get users in deparment here:
  static Future<dynamic> getUsersInDepartmentByDeptId(deptId) async {
    Uri uri = Uri.parse(
        "https://soft-doc.herokuapp.com/departments/users/${int.parse(deptId)}");
    http.Response response;
    try {
      response = await http.get(uri);

      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      } else {
        print(response.statusCode);
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("get users in department Error Message => " + e.toString());
      return null;
    }
  }

  //TODO: implement get sent docs here:
  static Future<dynamic> getSentDocsByUserId(userId) async {
    Uri uri = Uri.parse(
        "https://soft-doc.herokuapp.com/documents/user/${int.parse(userId)}");
    http.Response response;
    try {
      response = await http.get(uri);

      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      } else {
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      print("get sent documents Error Message => " + e.toString());
      return null;
    }
  }

  //TODO: implement getDoc by doc id:
  static Future<dynamic> getDocByDocId(docId) async {
    Uri uri = Uri.parse("https://soft-doc.herokuapp.com");
    http.Response response;
    try {
      response = await http.get(uri);
    } catch (e) {}
  }

  //TODO: implement get received docs here:
  static Future<dynamic> getReveivedDocsByUserId(userId) async {
    Uri uri = Uri.parse("");
    http.Response response;
    try {
      response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{'userId': userId},
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
      print("get doc by docId Error Message => " + e.toString());
      return null;
    }
  }

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
  static Future<dynamic> sendApproval(userId) async {
    Uri uri = Uri.parse("");
    http.Response response;
    try {
      response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{'userId': userId},
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
      print("send approval Error Message => " + e.toString());
      return null;
    }
  }

  static Future<bool> delectDocumentByDocumentId(docId) async {
    Uri uri = Uri.parse(
        "https://soft-doc.herokuapp.com/documents/delete/${int.parse(docId)}");
    http.Response response;
    try {
      response = await http.delete(uri);

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
}
