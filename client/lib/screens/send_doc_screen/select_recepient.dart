import 'package:flutter/material.dart';
import 'package:softdoc/cubit/data_cubit/data_cubit.dart';
import 'package:softdoc/style.dart';

class SelectRecipient extends StatefulWidget {
  final Function setMainState;
  Function setModalState;
  SelectRecipient({this.setMainState, this.setModalState, Key key})
      : super(key: key);

  @override
  _SelectRecipientState createState() => _SelectRecipientState();
}

class _SelectRecipientState extends State<SelectRecipient> {
  String currentState = 'idle';

  void rebuildSelectRecipient(String status) {
    setState(() {
      currentState = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Column(
            children: [
              if (widget.setModalState == null)
                Container(
                  height: 4,
                  color: primary,
                ),
              Container(
                height: 55,
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
                    DataCubit.selectedDept = DataCubit.departments
                        .singleWhere((dept) => dept.id == newVal);
                    // get users in selected department
                    if (DataCubit.selectedDept.users.length == 0)
                      DataCubit.getUsersInDept(DataCubit.selectedDept.id,
                          widget.setMainState, rebuildSelectRecipient);
                    widget.setMainState();
                    if (widget.setModalState != null)
                      widget.setModalState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
        // listview:-------------------------------------------------------------------------------------
        if (currentState == 'idle')
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              itemCount: DataCubit.selectedDept.users.length,
              itemBuilder: (context, index) {
                // checking if DataCubit.approvals contains this user's id
                bool selected = DataCubit.approvals
                    .contains(DataCubit.selectedDept.users[index].id);

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      color: primaryLight,
                      borderRadius: BorderRadius.circular(7)),
                  child: CheckboxListTile(
                    value: selected,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    title: Text(DataCubit.selectedDept.users[index].title),
                    activeColor: primary,
                    onChanged: (newVal) {
                      if (selected) {
                        // remove id if already selected
                        DataCubit.approvals
                            .remove(DataCubit.selectedDept.users[index].id);
                        widget.setMainState();
                        if (widget.setModalState != null)
                          widget.setModalState(() {});
                      } else {
                        // add id to approval list if not selected
                        DataCubit.approvals
                            .add(DataCubit.selectedDept.users[index].id);
                        widget
                            .setMainState(); // setState for the send screen to update approval ui
                        if (widget.setModalState != null)
                          widget.setModalState(() {}); // only needed in android
                      }
                    },
                  ),
                );
              },
            ),
          ),
        if (currentState == 'loading')
          Expanded(
              child: Center(
            child: CircularProgressIndicator(
              color: primary,
            ),
          )),
        if (currentState == 'failed')
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Something went wrong'),
              TextButton(
                onPressed: () => DataCubit.getUsersInDept(
                    DataCubit.selectedDept.id,
                    widget.setMainState,
                    rebuildSelectRecipient),
                child: Text('Try again'),
              ),
            ],
          ))
      ],
    );
  }
}
