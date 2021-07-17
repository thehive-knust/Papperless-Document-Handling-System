import 'package:flutter/material.dart';
import 'package:softdoc/models/doc.dart';
import 'package:softdoc/style.dart';

import 'docTypeIcon.dart';

class DocTiles extends StatelessWidget {
  final Map<String, List<Doc>> section;
  const DocTiles({Key key, this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return section.entries.map((entry) {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10),
        // color: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(entry.key, style: TextStyle(fontSize: 15)),
            ...entry.value.map((doc) => docTile(doc, context)).toList()
          ],
        ),
      );
    }).toList()[0];
  }

  docTile(doc, context) {
    Color status;
    if (doc.approved == null)
      status = yellow;
    else if (doc.approved)
      status = green;
    else if (!doc.approved) status = redLight;
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(DETAILPAGE, arguments: doc),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 3),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Dismissible(
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
            key: GlobalKey(),
            child: Container(
              height: 60,
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
                            "Request for classroom",
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
