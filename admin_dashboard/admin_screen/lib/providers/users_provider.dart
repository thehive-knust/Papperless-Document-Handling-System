import 'portfolio_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/alert_dialogs.dart';
import '../services/requests_to_backend.dart';
import '../models/user.dart';

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
    selectedUser = user;
    userEdited = false;
    final portfolioProvider =
        Provider.of<PortfolioProvider>(context!, listen: false);
    portfolioProvider.portfolios!['selectedPortfolio'] = user!.portfolio;
    portfolioProvider.departments!['selectedDepartment'] = user.deptId;
    portfolioProvider.faculties!['selectedFaculty'] = user.facId;
    notifyListeners();
  }

  DataRow createDataRow(User user) {
    return DataRow(
        cells: <DataCell>[
          DataCell(Text(user.firstName)),
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
        onSelectChanged: (selected) {
          if (selected!) showUserDetails(user);
        });
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
    bool? succeeded;
    final confirmed = await confirm(
        context!, "User Would be Deleted", "this action is irreversible");
    if (confirmed == true) {
      showProcessingAlert(context, "Deleting");
      succeeded = await Api.deleteUser(context!, userId);
      showMessage(context, status: succeeded);
    }
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
