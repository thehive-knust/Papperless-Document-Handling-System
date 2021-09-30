import 'package:flutter/material.dart';

import 'alert_dialog.dart';
import 'services/requests_to_backend.dart';
import 'user.dart';

class UsersProvider with ChangeNotifier {
  List<DataRow>? rowList;
  List<User>? users;
  BuildContext? context;
  User? selectedUser;
  bool userEdited = false;

  void updateUserEdited(bool value) {
    userEdited = value;
    notifyListeners();
  }

  void addUser(User user) {
    users!.add(user);
    rowList!.add(createDataRow(user));
    notifyListeners();
  }

  void removeUser(String userId) {
    users!.removeWhere((element) => element.id == userId);
    if (selectedUser != null && userId == selectedUser!.id) selectedUser = null;
    buildRowList();
    notifyListeners();
  }

  void buildRowList() {
    rowList = [];
    users!.forEach((user) {
      rowList!.add(createDataRow(user));
    });
  }

  void showUserDetails(User? user) {
    print(user);
    selectedUser = user;
    userEdited = false;
    notifyListeners();
  }

  DataRow createDataRow(User user) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(user.firstName), onTap: () {
          showUserDetails(user);
        }),
        DataCell(Text(user.lastName)),
        DataCell(Text(user.email)),
        DataCell(
          IconButton(
            onPressed: () async {
              bool succeeded = await deleteUserFromDb(user.id);
              if (succeeded == true) removeUser(user.id);
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red.shade400,
            ),
            splashColor: Colors.red.shade200,
          ),
        ),
      ],
    );
  }

  void updateUserDetails(Map<String, String> newAttributes) async {
    bool? succeeded;
    final currentDetails = selectedUser!.toMap();

    newAttributes.removeWhere((key, value) => value == currentDetails[key]);
    if (newAttributes.length == 0) {
      showMessage(context, message: "No changes made");
      return;
    }

    final confirmed = await confirm(
        context!, "Edit User's Details", "Old account details would be lost");

    if (confirmed == true) {
      showProcessingAlert(context, "Deleting");
      succeeded = await Api.editUserAttributes(
          context, selectedUser!.id, newAttributes);
      showMessage(context, status: succeeded);
      if (succeeded) {
        users!
            .singleWhere((element) => element.id == selectedUser!.id)
            .bulkEdit(newAttributes);
        selectedUser!.bulkEdit(newAttributes);
        notifyListeners();
      }
    }
  }

  Future<bool> deleteUserFromDb(userId) async {
    print('########################################');
    print(userId);
    bool? succeeded;
    final confirmed = await confirm(
        context!, "User Would be Deleted", "this action is irreversible");
    print('==========================confirmed=======================');
    print(confirmed);
    if (confirmed == true) {
      showProcessingAlert(context, "Deleting");
      succeeded = await Api.deleteUser(context!, userId);
      showMessage(context, status: succeeded);
    }
    print('==========================succeeded=======================');
    print(succeeded);
    return succeeded!;
  }

  void initialise(BuildContext buildcontext, List<dynamic> userlist) {
    users = [];
    context = buildcontext;
    userlist.forEach((user) {
      users!.add(User.fromJson(user));
    });

    buildRowList();

    notifyListeners();
  }
}
