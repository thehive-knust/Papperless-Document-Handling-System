import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:softdoc/models/department.dart';
import 'package:softdoc/models/doc.dart';
import 'package:softdoc/models/user.dart';
import 'package:softdoc/services/flask_database.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit() : super(DataInitial());
  static User user;
  static List<Department> departments = [];
  static Department selectedDept;
  static List<String> approvals = [];
  static String searchString = "";
  String bottomNavSelector = "Sent";
  int optionSel = 0;
  List<Doc> sentDocs;
  List<Doc> receivedDocs;
  Function homeScreenSetState;
  // Department selectedDept = departments[0];
  // List<String> approvals

  static List<Department> get depts => departments;

  static User getUser(id) {
    // gets a particular department user by his id.
    List<User> users = [];
    departments.forEach((dept) => users.addAll(dept.users));
    return users.singleWhere((user) => user.id == id);
  }

  //TODO: authenticate code:------------------------------------------------
  Future<bool> authenticate(String userId, String password) async {
    // authentication algo
    Map jsonData =
        await FlaskDatabase.authenticateWithIdAndPassword(userId, password);
    if (jsonData == null) {
      return false;
    } else if (jsonData.keys.contains('message')) {
      return true;
    } else {
      user = User.fromJson(jsonData['user']);
      print(user.toString());
      await getDepts(); // get departments in user's college
      await getUsersInDept(user.deptId); // get users in user's department.
      emit(Authenticated());
      return false;
    }
  }

  //TODO: get departments:
  Future<void> getDepts() async {
    dynamic jsonData = await FlaskDatabase.getDepartmentsByColId(user.colId);

    if (jsonData == null) {
    } else if (jsonData.keys.contains('message')) {
      print(jsonData['message']);
    } else {
      departments.clear();
      jsonData['departments'].forEach((deptJson) {
        departments.add(Department.fromJson(deptJson));
      });
      departments.add(Department(id: "others", name: "General", users: []));
      print(departments.toString());
    }
  }

  //TODO: get users in department:
  static Future<void> getUsersInDept(String deptId,
      [Function setMainState]) async {
    dynamic jsonData = await FlaskDatabase.getUsersInDepartmentByDeptId(deptId);
    if (jsonData == null) {
    } else if (jsonData.keys.contains('message')) {
      print(jsonData['message']);
    } else {
      int deptIndex = departments.indexWhere((dept) => dept.id == deptId);
      jsonData['department_users'].forEach((userJson) {
        User deptUser = User.fromJson(userJson);
        if (user.id != deptUser.id) departments[deptIndex].users.add(deptUser);
      });
      if (setMainState != null) setMainState();
      print(departments[deptIndex].users.toString());
      selectedDept = departments[deptIndex];
    }
  }

  //TODO: document handling code:-----------------------------------------

  //TODO: get Sent docs:
  Future<void> downloadSentDocs() async {
    dynamic jsonData = await FlaskDatabase.getSentDocsByUserId(user.id);
    if (jsonData == null) {
      emit(SentDoc(null));
    } else if (jsonData.keys.contains('message')) {
      emit(SentDoc(null));
    } else {
      sentDocs = [];
      jsonData['documents'].forEach((docJson) {
        sentDocs.add(Doc.fromJson(docJson));
      });
      sentDocs.sort((a, b) {
        // earliest in front
        if (a.updatedAt.isAfter(b.updatedAt)) {
          return -1;
        } else if (a.updatedAt.isBefore(b.updatedAt)) {
          return 1;
        }
        return 0;
      });
      //print(sentDocs.toString());
      bottomNavSelector = 'Sent';
      if (homeScreenSetState != null) homeScreenSetState();
      emit(SentDoc(getSections(sentDocs)));
    }
  }

  Future<void> downloadReceivedDocs() async {
    dynamic jsonData = await FlaskDatabase.getReceivedDocsByUserId(user.id);
    if (jsonData == null) {
      emit(ReceivedDoc(null));
    } else if (jsonData.keys.contains('message')) {
      emit(ReceivedDoc(null));
    } else {
      receivedDocs = [];
      jsonData['documents'].forEach((docJson) {
        receivedDocs.add(Doc.fromJson(docJson, false));
      });
      receivedDocs.sort((a, b) {
        // earliest in front
        if (a.updatedAt.isAfter(b.updatedAt)) {
          return -1;
        } else if (a.updatedAt.isBefore(b.updatedAt)) {
          return 1;
        }
        return 0;
      });
      print(receivedDocs.toString());
      bottomNavSelector = 'Received';
      if (homeScreenSetState != null) homeScreenSetState();
      emit(ReceivedDoc(getSections(receivedDocs)));
    }
  }

  void getDocsByOption() {
    bool isSent = bottomNavSelector == "Sent" ? true : false;
    if (optionSel == 0)
      getDocs(isSent);
    else if (optionSel == 1)
      getDocs(isSent, 'pending');
    else if (optionSel == 2)
      getDocs(isSent, 'approved');
    else if (optionSel == 3) getDocs(isSent, 'rejected');
  }

  void getDocs(bool isSent, [String status = ""]) {
    // check if sentDocs is null, if it is emit null;
    List<Doc> docs;
    if (isSent) {
      // sentDocs code:-----------------------------------
      if (sentDocs != null) {
        docs = status.isNotEmpty
            ? sentDocs.where((doc) => doc.status == status).toList()
            : sentDocs;
        docs = searchDocs(docs);
        emit(SentDoc(getSections(docs)));
      } else
        emit(SentDoc(null));
    } else {
      // receivedDocs code:-------------------------------------
      if (receivedDocs != null) {
        docs = status.isNotEmpty
            ? receivedDocs.where((doc) => doc.status == status).toList()
            : receivedDocs;
        docs = searchDocs(docs);
        emit(ReceivedDoc(getSections(docs)));
      } else
        emit(ReceivedDoc(null));
    }
  }

  List<Doc> searchDocs(List<Doc> docs) {
    return searchString.isNotEmpty
        ? docs
            .where((doc) =>
                doc.subject.toLowerCase().contains(searchString.toLowerCase()))
            .toList()
        : docs;
  }

  void sortReceivedDocs() {
    receivedDocs.sort((a, b) {
      // earliest in front
      if (a.updatedAt.isAfter(b.updatedAt)) {
        return -1;
      } else if (a.updatedAt.isBefore(b.updatedAt)) {
        return 1;
      }
      return 0;
    });
  }

  //TODO: upload doc:
  Future<bool> uploadDoc(Doc doc) => FlaskDatabase.sendDoc(doc);

  //TODO; delete doc:
  Future<bool> deleteDoc(docId) =>
      FlaskDatabase.delectDocumentByDocumentId(docId);

  //TODO: approval handling code:--------------------------------------
  Future<bool> statusUpdate(recId, docId, status) async =>
      await FlaskDatabase.sendApproval(recId, docId, status);

  clearDocs() {
    sentDocs = null;
    receivedDocs = null;
  }
}
