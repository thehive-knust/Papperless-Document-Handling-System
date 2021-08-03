import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softdoc/cubit/android_nav_cubit/AndroidNav_cubit.dart';
import 'package:softdoc/cubit/desktop_nav_cubit/desktopnav_cubit.dart';
import 'package:softdoc/models/doc.dart';
import 'package:softdoc/screens/home_screen/transition_animation.dart';
import 'package:softdoc/style.dart';

import '../../shared/docTypeIcon.dart';

class DocTiles extends StatelessWidget {
  // Map<String, List<Doc>> section;
  final isDesktop;
  final isSent;
  final List<Map<String, List<Doc>>> docs;
  DocTiles({this.docs, this.isDesktop, this.isSent});

  AndroidNavCubit _androidNavCubit;
  DesktopNavCubit _desktopNavCubit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(0.0, 10, 0.0, 60.0),
      itemCount: docs.length,
      itemBuilder: (context, index) => sectionWidget(
        context,
        docs[index],
      ),
    );
  }

  sectionWidget(context, section) {
    return section.entries.map((entry) {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10),
        // color: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(entry.key, style: TextStyle(fontSize: 15)),
            ...entry.value
                .asMap()
                .entries
                .map((doc) => docTile(doc, context))
                .toList()
          ],
        ),
      );
    }).toList()[0];
  }

  docTile(data, context) {
    _androidNavCubit = BlocProvider.of<AndroidNavCubit>(context);
    _desktopNavCubit = BlocProvider.of<DesktopNavCubit>(context);
    Doc doc = data.value;
    int index = data.key;
    Color status;
    if (doc.status == 'pending')
      status = yellow;
    else if (doc.status == 'approved')
      status = green;
    else if (doc.status == 'rejected')
      status = redLight;
    else
      status = Colors.grey[300];
    return TransitionAnimation(
      delay: index,
      child: GestureDetector(
        onTap: () {
          if (isSent) {
            isDesktop
                ? _desktopNavCubit.navToDetailScreen(doc)
                : _androidNavCubit.navToDetailScreen(doc);
          } else {
            isDesktop
                ? _desktopNavCubit.navToReveivedDetailScreen(doc)
                : _androidNavCubit.navToReveivedDetailScreen(doc);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 3),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Dismissible(
              key: GlobalKey(),
              direction: DismissDirection.endToStart,
              confirmDismiss: (direction) => alertDialog(direction, context),
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.centerRight,
                color: Colors.lightBlue[300],
                child: Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                ),
              ),
              child: Container(
                height: 61,
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      width: 5,
                      color: status,
                      margin: EdgeInsets.only(right: 15),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doc.subject,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 5),
                            Text("10: 30 AM",
                                style: TextStyle(color: Colors.grey))
                          ],
                        ),
                      ),
                    ),
                    DocTypeIcon(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> alertDialog(
      DismissDirection direction, BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure?"),
        content: Text("this action is irreversible"),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop(true),
            child: Text("DELETE", style: TextStyle(color: Colors.redAccent)),
          ),
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("CANCEL"))
        ],
      ),
    );
  }
}
