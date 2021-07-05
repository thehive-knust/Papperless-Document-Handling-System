import 'package:flutter/material.dart';
import 'package:softdoc/models/doc.dart';

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
            ...entry.value.map((doc) => docTile(doc)).toList()
          ],
        ),
      );
    }).toList()[0];
  }

  docTile(doc) {
    Color status;
    if (doc.status == 'in progress')
      status = Colors.yellowAccent.withOpacity(0.8);
    if (doc.status == 'approved') status = Colors.greenAccent;
    if (doc.status == 'rejected') status = Colors.red.shade200;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Dismissible(
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
                        Text("10: 30 AM", style: TextStyle(color: Colors.grey))
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  alignment: Alignment.center,
                  height: 35,
                  width: 35,
                  child: Text('PDF',
                      style: TextStyle(fontSize: 13, color: Colors.black54)),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(7),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
