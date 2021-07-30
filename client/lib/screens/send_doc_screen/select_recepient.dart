import 'package:flutter/material.dart';
import 'package:softdoc/models/department.dart';
import 'package:softdoc/style.dart';
import '../../utills.dart';

// List<Department> departments = Department.departments;
// Department selectedDept = departments[0];
// List<String> approvals = [];

selectRecepient(Function setMainState, [Function setModalState]) {
  return Column(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Column(
          children: [
            if (setModalState == null)
              Container(
                height: 4,
                color: primary,
              ),
            Container(
              height: 55,
              // alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              color: primaryLight,
              child: DropdownButton<String>(
                value: selectedDept.id,
                isExpanded: true,
                underline: SizedBox.shrink(),
                icon: Icon(Icons.arrow_drop_down, color: primaryDark),
                items: departments
                    .map(
                      (dept) => DropdownMenuItem<String>(
                        child: Text(
                          dept.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        value: dept.id,
                      ),
                    )
                    .toList(),
                onChanged: (newVal) {
                  print(newVal);
                  selectedDept =
                      departments.singleWhere((dept) => dept.id == newVal);
                  // get users in selected department
                  setMainState();
                  if (setModalState != null) setModalState(() {});
                },
              ),
            ),
          ],
        ),
      ),
      // listview:-------------------------------------------------------------------------------------
      Expanded(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          itemCount: selectedDept.users.length,
          itemBuilder: (context, index) {
            // checking if approvals contains this user's id
            bool selected = approvals.contains(selectedDept.users[index].id);

            return Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  color: primaryLight, borderRadius: BorderRadius.circular(7)),
              child: CheckboxListTile(
                value: selected,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                title: Text(selectedDept.users[index].title),
                activeColor: primary,
                onChanged: (newVal) {
                  if (selected) {
                    // remove id if already selected
                    approvals.remove(selectedDept.users[index].id);
                    setMainState();
                    if (setModalState != null) setModalState(() {});
                  } else {
                    // add id to approval list if not selected
                    approvals.add(selectedDept.users[index].id);
                    setMainState(); // setState for the send screen to update approval ui
                    if (setModalState != null)
                      setModalState(() {}); // only needed in android
                  }
                },
              ),
            );
          },
        ),
      )
    ],
  );
}
