import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:softdoc/models/department.dart';
import 'package:softdoc/screens/send_doc_screen/select_recepient.dart';
import '../../style.dart';
import '../../utills.dart';

Widget addOrEditReciepient(bool isDesktop, Function setMainState) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: primaryLight,
    ),
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: ListView(
      shrinkWrap: isDesktop ? false : true,
      children: [
        ...approvals.map(
          (id) {
            // getting the title for each user with the id.
            String title =
                Department.getUsers.singleWhere((user) => user.id == id).title;
            return Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(title),
            );
          },
        ),
        if (isDesktop && approvals.isEmpty)
          DottedBorder(
            padding: EdgeInsets.symmetric(horizontal: 10),
            color: primary.withOpacity(0.6),
            borderType: BorderType.RRect,
            radius: Radius.circular(6),
            dashPattern: [5],
            child: Container(
              height: 35,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "No recipient added",
                    style: TextStyle(color: Colors.black38),
                  ),
                ],
              ),
            ),
          ),
        if(!isDesktop)
          Builder(
            builder: (context) => GestureDetector(
              onTap: () {
                // if (!isDesktop) selectRecepient(context, setMainState);
                if (!isDesktop) {
                  showModalBottomSheet(
                    context: context,
                    barrierColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      double height = MediaQuery.of(context).size.height;
                      return StatefulBuilder(
                        builder: (context, setModalState) => Container(
                          height: height,
                          margin: EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(.0, -2), color: Colors.black12)
                            ],
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              child:
                                  selectRecepient(setMainState, setModalState)),
                        ),
                      );
                    },
                  );
                }
              },
              child: DottedBorder(
                padding: EdgeInsets.symmetric(horizontal: 10),
                color: primary.withOpacity(0.6),
                borderType: BorderType.RRect,
                radius: Radius.circular(6),
                dashPattern: [5],
                child: Container(
                  height: 35,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add or edit recipient(s)",
                        style: TextStyle(color: Colors.black38),
                      ),
                      Icon(Icons.add, color: primary)
                    ],
                  ),
                ),
              ),
            ),
          )
      ],
    ),
  );
}
