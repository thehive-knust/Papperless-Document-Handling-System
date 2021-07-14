import 'package:flutter/material.dart';
import 'package:softdoc/models/department.dart';
import 'package:softdoc/style.dart';

List<Department> departments = Department.departments;
Department selectedDept = departments[0];
List<String> approvals = [];

selectRecepient(BuildContext context, Function setMainState) {
  double height = MediaQuery.of(context).size.height;
  showModalBottomSheet(
    barrierColor: Colors.transparent,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        // header:--------------------------------------------------------------------------------
        builder: (context, setState) => Container(
          height: height * 0.53,
          margin: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(offset: Offset(.0, -2), color: Colors.black12)
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: Column(
              children: [
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
                          (e) => DropdownMenuItem<String>(
                            child: Text(e.name),
                            value: e.id,
                          ),
                        )
                        .toList(),
                    onChanged: (newVal) {
                      print(newVal);
                      selectedDept =
                          departments.singleWhere((dept) => dept.id == newVal);
                      setState(() {});
                    },
                  ),
                ),
                // listview:-------------------------------------------------------------------------------------
                Expanded(
                  child: ListView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      itemCount: selectedDept.offices.length,
                      itemBuilder: (context, index) {
                        bool selected =
                            approvals.contains(selectedDept.offices[index].id);
                        return GestureDetector(
                          onTap: () {
                            if (selected) {
                              approvals.remove(selectedDept.offices[index].id);
                              setMainState(); 
                              setState((){});
                            } else {
                              approvals.add(selectedDept.offices[index].id);
                              setMainState();
                              setState((){});
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                color:
                                    selected ? Colors.grey[200] : primaryLight,
                                borderRadius: BorderRadius.circular(7)),
                            height: 50,
                            width: double.infinity,
                            child: Text(selectedDept.offices[index].portfolio),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
