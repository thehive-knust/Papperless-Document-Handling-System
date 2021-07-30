import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:softdoc/models/department.dart';
import 'package:softdoc/models/doc.dart';
import 'package:softdoc/models/user.dart';
import "package:softdoc/models/doc.dart";

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit() : super(DataInitial());
  User user;
  List<Department> departments;
  // Department selectedDept = departments[0];
  // List<String> approvals;

  //TODO: authenticate code:-------------------------------------------
  void authenticate() {
    // authentication algo
    emit(SentDoc(Doc.sentDocs));
  }

  //TODO: get departments:
  void getDepartments() {
    departments = Department.dumyJson().map(
      (dept) {
        // List<User> users = Users.dumyJson().map()
        return Department();
      },
    );
  }

  //TODO: get users in department:

  //TODO: document handling code:--------------------------------------

  //TODO: get Sent docs:
  void getSent() {
    emit(SentDoc(Doc.sentDocs));
  }

  //TODO: get reveived docs:
  void getReceived() {
    emit(ReveivedDoc(Doc.reveivedDocs));
  }

  //TODO: upload doc:

  //TODO: getUserData:

  //TODO: approval handling code:--------------------------------------

}
