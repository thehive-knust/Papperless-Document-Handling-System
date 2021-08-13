import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:softdoc/cubit/android_nav_cubit/AndroidNav_cubit.dart';
import 'package:softdoc/cubit/data_cubit/data_cubit.dart';
import 'package:softdoc/cubit/desktop_nav_cubit/desktopnav_cubit.dart';
import 'package:softdoc/screens/home_screen/doc_tile.dart';
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
  int optionSel = 0;

  @override
  void initState() {
    super.initState();
    _androidNavCubit = BlocProvider.of<AndroidNavCubit>(context);
    _desktopNavCubit = BlocProvider.of<DesktopNavCubit>(context);
    _dataCubit = BlocProvider.of<DataCubit>(context);
    _dataCubit.downloadDocs();

    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.white
      ..contentPadding = EdgeInsets.all(30)
      ..indicatorType = EasyLoadingIndicatorType.doubleBounce
      ..indicatorColor = primary
      ..progressColor = primary
      ..textColor = Colors.black
      ..maskType = EasyLoadingMaskType.black
      ..successWidget = Icon(Icons.check_rounded, size: 50, color: Colors.green)
      ..errorWidget = Icon(Icons.cancel_rounded, size: 50, color: Colors.red);
  }

  void getDocsByOption() {
    // anytime the user filters the document, we want to get the appropiate
    // docs,
    // if he searches, he searches the filtered docs,
    //this methods keeps track of the filtering type.
    bool isSent = bottomNavSelector == 'Sent' ? true : false;
    if (optionSel == 0)
      _dataCubit.getDocs(isSent);
    else if (optionSel == 1)
      _dataCubit.getDocs(isSent, 'pending');
    else if (optionSel == 2)
      _dataCubit.getDocs(isSent, 'approved');
    else if (optionSel == 3) _dataCubit.getDocs(isSent, 'rejected');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.isDesktop
              ? _desktopNavCubit.navToSendDocScreen()
              : _androidNavCubit.navToSendDocScreen();
        },
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
          Container(
            width: 115,
            height: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: DropdownButton<int>(
              value: optionSel,
              isExpanded: true,
              iconEnabledColor: primaryDark,
              underline: SizedBox.shrink(),
              onChanged: (newVal) {
                optionSel = newVal;
                getDocsByOption();
              },
              items: ["All", "Pending", "Approved", "Rejected"]
                  .asMap()
                  .entries
                  .map(
                    (option) => DropdownMenuItem(
                      value: option.key,
                      child: Text(option.value),
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(width: 10),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (val) {
              _dataCubit.emit(DataInitial());
            },
            itemBuilder: (context) => ["Log out"]
                .asMap()
                .entries
                .map(
                  (option) => PopupMenuItem(
                      value: option.key, child: Text(option.value)),
                )
                .toList(),
          ),
        ],
      ),
      // body:------------------------------------------------------------------------------------------
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        width: double.infinity,
        height: double.infinity,
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
                onChanged: (srch) {
                  DataCubit.searchString = srch;
                  getDocsByOption();
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: InputBorder.none,
                  hintText: "Search",
                ),
              ),
            ),
            // listView:-----------------------------------------------------------
            BlocBuilder<DataCubit, DataState>(
              builder: (context, state) {
                // sentDoc state:--------------------------------------------------
                if (state is SentDoc) {
                  if (state.docs == null) {
                    return errorWidget();
                  } else if (state.docs.isEmpty) {
                    return emptyList();
                  }
                  return Expanded(
                    child: DocTiles(
                      docs: state.docs,
                      isDesktop: widget.isDesktop,
                      isSent: true,
                    ),
                  );
                }
                // receivedDoc State:-------------------------------------------------------------
                else if (state is ReceivedDoc) {
                  if (state.docs == null) {
                    return errorWidget();
                  } else if (state.docs.isEmpty) {
                    return emptyList(false);
                  }
                  return Expanded(
                    child: DocTiles(
                      docs: state.docs,
                      isDesktop: widget.isDesktop,
                      isSent: false,
                    ),
                  );
                }
                // loading state:---------------------------------------------------------------------------
                else
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: primary),
                        SizedBox(height: 10),
                        Text("Loading documents"),
                      ],
                    ),
                  );
              },
            )
          ],
        ),
      ),
    );
  }

  //Error widget:-----------------------------------
  Widget errorWidget() => Center(
        child: Container(
          width: double.infinity,
          height: 500,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Error connecting to server",
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 30, vertical: 20)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  _dataCubit.downloadDocs();
                  _dataCubit.emit(Authenticated());
                },
                child: Text("Reload"),
              )
            ],
          ),
        ),
      );

  //Empty list widget:-------------------------------
  Widget emptyList([isSent = true]) => Container(
        width: double.infinity,
        height: 500,
        child: CircleAvatar(
          radius: double.infinity,
          backgroundColor: Colors.white70,
          child: isSent
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Tap ",
                        style:
                            TextStyle(fontSize: 20, color: Colors.grey[600])),
                    Icon(Icons.note_add_rounded, color: Colors.grey[600]),
                    Text(" to add a document",
                        style: TextStyle(fontSize: 20, color: Colors.grey[600]))
                  ],
                )
              : Text(
                  "No documents",
                  style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                ),
        ),
      );

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
                            bottomNavSelector = map.key;
                            if (map.key == 'Sent')
                              // _dataCubit.getAll(true);
                              getDocsByOption();
                            else
                              _dataCubit.emit(ReceivedDoc(Doc.reveivedDocs));
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
