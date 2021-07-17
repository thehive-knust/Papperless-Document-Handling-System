import 'package:flutter/material.dart';
import 'package:softdoc/screens/home_screen/doc_tile.dart';
import '../../models/doc.dart';
import 'package:softdoc/style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(SENDPAGE),
        backgroundColor: primary,
        child: Icon(Icons.note_add_rounded),
      ),
      backgroundColor: Colors.blueGrey[50],
      // appbar:---------------------------------------------------------------------------------
      appBar: AppBar(
        title: Text(
          "SoftDoc",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: primaryDark,
            fontSize: 25,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actionsIconTheme: IconThemeData(color: primaryDark),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.sort_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      // body:------------------------------------------------------------------------------------------
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        width: double.infinity,
        // color: Colors.blue,
        child: Column(
          children: [
            // searchbar:--------------------------------------------------------------
            Container(
              height: 45,
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: InputBorder.none,
                  hintText: "Search",
                ),
              ),
            ),
            // listView:-----------------------------------------------------------
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 10),
                itemBuilder: (context, index) =>
                    DocTiles(section: Doc.docs[index]),
                itemCount: Doc.docs.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
