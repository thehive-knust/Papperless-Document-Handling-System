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
  List<Doc> sentDocs; //DONE: don't initialize sentdocs here
  List<Doc> receivedDocs = [];
  // Department selectedDept = departments[0];
  // List<String> approvals

  static List<Department> get depts => departments;

  static User getUser(id) {
    // gets a particular department user by his id.
    List<User> users = [];
    departments.forEach((dept) => users.addAll(dept.users));
    return users.singleWhere((user) => user.id == id);
  }

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
      user = User.fromJson(jsonData['user']);
      print(user.toString());
      await getDepts(); // get departments in user's college
      await getUsersInDept(); // get users in user's department
      selectedDept = departments.singleWhere((dept) => dept.id == user.deptId);
      // get sent documents
      // get revieved documents
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
      jsonData['departments'].forEach((deptJson) {
        departments.add(Department.fromJson(deptJson));
      });
      print(departments.toString());
    }
  }

  //TODO: get users in department:
  Future<void> getUsersInDept() async {
    dynamic jsonData =
        await FlaskDatabase.getUsersInDepartmentByDeptId(user.deptId);
    if (jsonData == null) {
    } else if (jsonData.keys.contains('message')) {
      print(jsonData['message']);
    } else {
      int deptIndex = departments.indexWhere((dept) => dept.id == user.deptId);
      jsonData['department_users'].forEach((userJson) {
        departments[deptIndex].users.add(User.fromJson(userJson));
      });
      print(departments[deptIndex].users.toString());
    }
  }

  //TODO: document handling code:--------------------------------------

  //TODO: get Sent docs:
  Future<void> downloadDocs() async {
    dynamic jsonData = await FlaskDatabase.getSentDocsByUserId(user.id);
    if (jsonData == null) {
      emit(SentDoc(null));
    } else if (jsonData.keys.contains('message')) {
      emit(SentDoc(null));
    } else {
      // sentDocs.clear(); //TODO: initialize the sentdocs here instead.
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
      print(sentDocs.toString());
      emit(SentDoc(getSections(sentDocs)));
    }
  }

  void getDocs(bool isSent, [String status = ""]) {
    // check if sentDocs is null, if it is emit null;
    List<Doc> docs;
    if (isSent) { // sentDocs code:-----------------------------------
      if (sentDocs != null) {
        docs = status.isNotEmpty
            ? sentDocs.where((doc) => doc.status == status).toList()
            : sentDocs;
        docs = searchDocs(docs);
        emit(SentDoc(getSections(docs)));
      } else
        emit(SentDoc(null));
    } else { // receivedDocs code:-------------------------------------
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
    emit(ReceivedDoc(Doc.reveivedDocs));
  }

  //TODO: upload doc:
  Future<bool> uploadDoc(Doc doc) => FlaskDatabase.sendDoc(doc);

  //TODO: getDoc:
  Future<Doc> getDoc(docId) async {
    dynamic jsonData = await FlaskDatabase.getDocByDocId(docId);
    if (jsonData == null) {
    } else if (jsonData.keys.contians("message")) {
    } else {
      return Doc.fromJson(jsonData);
    }
  }

  //TODO; delete doc:
  Future<bool> deleteDoc(docId) =>
      FlaskDatabase.delectDocumentByDocumentId(docId);

  //TODO: getUserData:

  //TODO: approval handling code:--------------------------------------

}
