import 'package:flutter/material.dart';

class UsersProvider with ChangeNotifier {
  List<DataRow>? rowList;

  void addRow(DataRow row) {
    rowList!.add(row);
    notifyListeners();
  }

  void removeRow(DataRow row) {
    rowList!.remove(row);
    notifyListeners();
  }

  void initialise(List<dynamic> users) {
    rowList = [];
    users.forEach((element) {
      rowList!.add(DataRow(
        cells: <DataCell>[
          DataCell(Text(element['first_name'])),
          DataCell(Text(element['last_name'])),
          DataCell(Text(element['email'])),
          DataCell(IconButton(
            onPressed: () {
              print('########################################');
              print(element['id']);
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red.shade400,
            ),
            splashColor: Colors.red.shade200,
          )),
        ],
      ));
    });
    notifyListeners();
  }
}
