import 'package:flutter/material.dart';
import 'package:softdoc/cubit/data_cubit/data_cubit.dart';
import 'package:softdoc/models/department.dart';
import 'package:softdoc/style.dart';
import '../../utills.dart';

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
                value: DataCubit.selectedDept.id,
                isExpanded: true,
                underline: SizedBox.shrink(),
                icon: Icon(Icons.arrow_drop_down, color: primaryDark),
                items: DataCubit.departments
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
          itemCount: DataCubit.selectedDept.users.length,
          itemBuilder: (context, index) {
            // checking if DataCubit.approvals contains this user's id
            bool selected = DataCubit.approvals.contains(selectedDept.users[index].id);

            return Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  color: primaryLight, borderRadius: BorderRadius.circular(7)),
              child: CheckboxListTile(
                value: selected,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                title: Text(DataCubit.selectedDept.users[index].title),
                activeColor: primary,
                onChanged: (newVal) {
                  if (selected) {
                    // remove id if already selected
                    DataCubit.approvals.remove(DataCubit.selectedDept.users[index].id);
                    setMainState();
                    if (setModalState != null) setModalState(() {});
                  } else {
                    // add id to approval list if not selected
                    DataCubit.approvals.add(DataCubit.selectedDept.users[index].id);
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
