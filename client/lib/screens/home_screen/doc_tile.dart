import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:softdoc/cubit/android_nav_cubit/AndroidNav_cubit.dart';
import 'package:softdoc/cubit/data_cubit/data_cubit.dart';
import 'package:softdoc/cubit/desktop_nav_cubit/desktopnav_cubit.dart';
import 'package:softdoc/models/doc.dart';
import 'package:softdoc/screens/home_screen/transition_animation.dart';
import 'package:softdoc/style.dart';

import '../../shared/docTypeIcon.dart';

class DocTiles extends StatefulWidget {
  // Map<String, List<Doc>> section;
  final isDesktop;
  final isSent;
  final List<Map<String, List<Doc>>> docs;
  DocTiles({required this.docs, this.isDesktop, this.isSent});

  @override
  _DocTilesState createState() => _DocTilesState();
}

class _DocTilesState extends State<DocTiles> {
  DataCubit? _dataCubit;

  AndroidNavCubit? _androidNavCubit;

  DesktopNavCubit? _desktopNavCubit;

  @override
  void initState() {
    super.initState();
    _androidNavCubit = BlocProvider.of<AndroidNavCubit>(context);
    _desktopNavCubit = BlocProvider.of<DesktopNavCubit>(context);
    _dataCubit = BlocProvider.of<DataCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.wait(
          [_dataCubit!.downloadReceivedDocs(), _dataCubit!.downloadSentDocs()],
        );
      },
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(0.0, 10, 0.0, 60.0),
        itemCount: widget.docs.length,
        itemBuilder: (context, index) =>
            sectionWidget(context, widget.docs[index], index),
      ),
    );
  }

  sectionWidget(context, Map<String, List<Doc>> section, index) {
    _dataCubit!.selectedIndexes.add(-1);
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
                .map((doc) => docTile(doc, entry.value, context, index))
                .toList()
          ],
        ),
      );
    }).toList()[0];
  }

  docTile(data, List<Doc> docs, context, sectionIndex) {
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
      status = Colors.grey[300]!;
    return TransitionAnimation(
      delay: index,
      child: GestureDetector(
        onTap: () {
          if (widget.isSent) {
            widget.isDesktop
                ? _desktopNavCubit!.navToDetailScreen(doc)
                : _androidNavCubit!.navToDetailScreen(doc);
          } else {
            widget.isDesktop
                ? _desktopNavCubit!.navToreceivedDetailScreen(doc)
                : _androidNavCubit!.navToreceivedDetailScreen(doc);
          }
          _dataCubit!.selectedIndexes =
              _dataCubit!.selectedIndexes.map((e) => -1).toList();
          _dataCubit!.selectedIndexes[sectionIndex] = index;
          setState(() {});
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 3),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Dismissible(
              key: GlobalKey(),
              direction: widget.isSent
                  ? DismissDirection.endToStart
                  : DismissDirection.none,
              confirmDismiss: (direction) =>
                  alertDialog(direction, context, doc.id!),
              onDismissed: (direction) {
                _dataCubit!.sentDocs!.remove(docs[index]);
                docs.removeAt(index);
                setState(() {});
              },
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
                color: _dataCubit!.selectedIndexes[sectionIndex] == index
                    ? primaryLight
                    : Colors.white,
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
                              doc.subject!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 5),
                            Text(DateFormat("h:m a").format(doc.updatedAt!),
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

  Future<bool?> alertDialog(
      DismissDirection direction, BuildContext context, String id) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure?"),
        content: Text("this action is irreversible"),
        actions: [
          TextButton(
            onPressed: () async {
              await EasyLoading.show(status: "Deleting document");
              bool success = await _dataCubit!.deleteDoc(id);
              if (success) {
                await EasyLoading.showSuccess("Document deleted",
                    dismissOnTap: true);
                Navigator.of(context, rootNavigator: true).pop(true);
                _desktopNavCubit!.navToHomeScreen();
              } else {
                EasyLoading.showError('Document not deleted, try again',
                    dismissOnTap: true);
                Navigator.pop(context);
              }
            },
            child: Text("DELETE", style: TextStyle(color: Colors.redAccent)),
          ),
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("CANCEL"))
        ],
      ),
    );
  }
}
