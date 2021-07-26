import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softdoc/cubit/android_nav_cubit/AndroidNav_cubit.dart';
import 'package:softdoc/cubit/desktop_nav_cubit/desktopnav_cubit.dart';
import 'package:softdoc/screens/home_screen/doc_tile.dart';
import 'package:softdoc/screens/send_doc_screen/send_doc_screen.dart';
import '../../models/doc.dart';
import 'package:softdoc/style.dart';

class HomeScreen extends StatefulWidget {
  final bool isDesktop;
  const HomeScreen({Key key, this.isDesktop = false}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AndroidNavCubit _androidNavCubit;
  DesktopNavCubit _desktopNavCubit;

  @override
  void initState() {
    super.initState();
    _androidNavCubit = BlocProvider.of<AndroidNavCubit>(context);
    _desktopNavCubit = BlocProvider.of<DesktopNavCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // onPressed: () => Navigator.of(context).pushNamed(SENDPAGE),
        onPressed: () => widget.isDesktop
            ? _desktopNavCubit.navToSendDocScreen()
            : _androidNavCubit.navToSendDocScreen(),
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
                itemBuilder: (context, index) => DocTiles(
                  section: Doc.docs[index],
                  isDesktop: widget.isDesktop,
                ),
                itemCount: Doc.docs.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
