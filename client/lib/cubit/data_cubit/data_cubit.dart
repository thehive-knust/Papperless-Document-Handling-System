import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:softdoc/models/department.dart';
import 'package:softdoc/models/doc.dart';
import 'package:softdoc/models/user.dart';
import "package:softdoc/models/doc.dart";
import 'package:softdoc/services/flask_database.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit() : super(DataInitial());
  User user;
  List<Department> departments;
  List<Doc> sentDocs;
  List<Doc> receivedDocs;
  // Department selectedDept = departments[0];
  // List<String> approvals;

  //TODO: authenticate code:-------------------------------------------
  Future<bool> authenticate(String userId, String password) async {
    // authentication algo
    Map jsonData =
        await FlaskDatabase.authenticateWithIdAndPassword(userId, password);
    if (jsonData == null) {
      return false;
    } else if (jsonData.keys.contains('message')) {
      return true;
    } else {
      user = User.fromJson(jsonData);
      // get departments in user's college
      // get users in user's department
      // get sent documents
      // get revieved documents
      emit(SentDoc(Doc.sentDocs));
      return false;
    }
  }

  //TODO: get departments:
  void getDepts() async {
    dynamic jsonData = await FlaskDatabase.getDepartmentsByColId(user.colId);

    if (jsonData == null) {
    } else if (jsonData.keys.contains('message')) {
    } else {
      jsonData.forEach((deptJson) {
        departments.add(Department.fromJson(deptJson));
      });
    }
  }

  //TODO: get users in department:
  void getUsersInDept([deptId]) async {
    dynamic jsonData =
        await FlaskDatabase.getUsersInDepartmentByDeptId(user.deptId);
    if (jsonData == null) {
    } else if (jsonData.keys.contains('message')) {
    } else {
      int deptIndex = departments.indexWhere((dept) => dept.id == user.deptId);
      jsonData.forEach((userJson) {
        departments[deptIndex].users.add(User.fromJson(userJson));
      });
    }
  }

  //TODO: document handling code:--------------------------------------

  //TODO: get Sent docs:
  void getSent() async {
    dynamic jsonData = await FlaskDatabase.getSentDocsByUserId(user.id);
    if (jsonData == null) {
    } else if (jsonData.keys.contains('message')) {
    } else {
      jsonData.forEach((docJson) {
        sentDocs.add(Doc.fromJson(docJson));
      });
    }
    emit(SentDoc(Doc.sentDocs));
  }

  //TODO: get reveived docs:
  void getReceived() async {
    dynamic jsonData = await FlaskDatabase.getReveivedDocsByUserId(user.id);
    if (jsonData == null) {
    } else if (jsonData.keys.contains('message')) {
    } else {
      jsonData.forEach((docJson) {
        receivedDocs.add(Doc.fromJson(docJson));
      });
    }
    emit(ReveivedDoc(Doc.reveivedDocs));
  }

  //TODO: upload doc:
  void uploadDoc(Doc doc) async {
    dynamic success = await FlaskDatabase.sendDoc(doc);
    if (success == null) {
      // do something
    } else if (success.keys.contains("message")) {
    } else {
      // return true;
    }
  }

  //TODO: getDoc:
  Future<Doc> getDoc(docId) async {
    dynamic jsonData = await FlaskDatabase.getDocByDocId(docId);
    if (jsonData == null) {
    } else if (jsonData.keys.contians("message")) {
    } else {
      return Doc.fromJson(jsonData);
    }
  }

  //TODO: getUserData:

  //TODO: approval handling code:--------------------------------------

}
