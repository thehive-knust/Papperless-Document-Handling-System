import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softdoc/cubit/android_nav_cubit/AndroidNav_cubit.dart';
import 'package:softdoc/cubit/data_cubit/data_cubit.dart';
import 'package:softdoc/cubit/desktop_nav_cubit/desktopnav_cubit.dart';
import 'package:softdoc/screens/home_screen/doc_tile.dart';
import 'package:softdoc/screens/home_screen/transition_animation.dart';
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
  DataCubit _dataCubit;
  String bottomNavSelector = "Sent";

  @override
  void initState() {
    super.initState();
    _androidNavCubit = BlocProvider.of<AndroidNavCubit>(context);
    _desktopNavCubit = BlocProvider.of<DesktopNavCubit>(context);
    _dataCubit = BlocProvider.of<DataCubit>(context);
    _dataCubit.getSent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        // onPressed: () => Navigator.of(context).pushNamed(SENDPAGE),
        onPressed: () => widget.isDesktop
            ? _desktopNavCubit.navToSendDocScreen()
            : _androidNavCubit.navToSendDocScreen(),
        backgroundColor: primary,
        child: Icon(Icons.note_add_rounded),
      ),
      backgroundColor: Colors.blueGrey[50],
      bottomNavigationBar: bottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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
              child: BlocBuilder<DataCubit, DataState>(
                builder: (context, state) {
                  if (state is SentDoc) {
                    return DocTiles(
                      docs: state.docs,
                      isDesktop: widget.isDesktop,
                      isSent: true,
                    );
                  } else if (state is ReveivedDoc) {
                    return DocTiles(
                      docs: state.docs,
                      isDesktop: widget.isDesktop,
                      isSent: false,
                    );
                  } else
                    return LinearProgressIndicator();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  //BottomNavBar widget:----------------------------
  Widget bottomNavBar() {
    Map<String, dynamic> buttons = {
      "Sent": Icons.send,
      "Reveived": Icons.receipt,
      "space": "_",
    };

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...buttons.entries.map(
              (map) {
                return map.value == '_'
                    ? SizedBox(width: 60)
                    : Expanded(
                        child: InkWell(
                          splashColor: Color(0xFF6D95E6).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(70),
                          onTap: () {
                            if (map.key == 'Sent')
                              _dataCubit.getSent();
                            else
                              _dataCubit.getReceived();
                            bottomNavSelector = map.key;
                            setState(() {});
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                map.value,
                                size: 30,
                                color: bottomNavSelector == map.key
                                    ? primary
                                    : Colors.grey,
                              ),
                              Text(map.key, style: TextStyle(fontSize: 12))
                            ],
                          ),
                        ),
                      );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}
