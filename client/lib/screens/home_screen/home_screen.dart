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
  const HomeScreen({Key? key, this.isDesktop = false}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AndroidNavCubit? _androidNavCubit;
  DesktopNavCubit? _desktopNavCubit;
  DataCubit? _dataCubit;
  // String bottomNavSelector = "Sent";
  // int optionSel = 0;

  @override
  void initState() {
    super.initState();
    _androidNavCubit = BlocProvider.of<AndroidNavCubit>(context);
    _desktopNavCubit = BlocProvider.of<DesktopNavCubit>(context);
    _dataCubit = BlocProvider.of<DataCubit>(context);
    if (_dataCubit!.sentDocs == null) {
      _dataCubit!.downloadReceivedDocs();
      _dataCubit!.downloadSentDocs();
      setState(() {});
    }

    _dataCubit!.selectedIndexes =
        _dataCubit!.selectedIndexes.map((e) => -1).toList();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.isDesktop
              ? _desktopNavCubit!.navToSendDocScreen()
              : _androidNavCubit!.navToSendDocScreen();
          _dataCubit!.selectedIndexes =
              _dataCubit!.selectedIndexes.map((e) => -1).toList();
          setState(() {});
        },
        backgroundColor: primary,
        child: Icon(Icons.note_add_rounded),
      ),
      backgroundColor: Colors.blueGrey[50],
      bottomNavigationBar: bottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
              value: _dataCubit!.optionSel,
              isExpanded: true,
              iconEnabledColor: primaryDark,
              underline: SizedBox.shrink(),
              onChanged: (newVal) {
                _dataCubit!.optionSel = newVal;
                _dataCubit!.selectedIndexes =
                    _dataCubit!.selectedIndexes.map((e) => -1).toList();
                _desktopNavCubit!.navToHomeScreen();
                _dataCubit!.getDocsByOption();
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
              _dataCubit!.clearDocs();
              _dataCubit!.emit(DataInitial());
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
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    margin: EdgeInsets.only(bottom: 5, right: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: TextField(
                      onChanged: (srch) {
                        DataCubit.searchString = srch;
                        // getDocsByOption();
                        _dataCubit!.getDocsByOption();
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: InputBorder.none,
                        hintText: "Search",
                      ),
                    ),
                  ),
                ),
                if (widget.isDesktop)
                  StatefulBuilder(
                    builder: (context, setState) {
                      return DataCubit.refreshingDocList!
                          ? CircularProgressIndicator(color: primary)
                          : IconButton(
                              onPressed: () async {
                                if (_dataCubit!.bottomNavSelector == "Sent")
                                  _dataCubit!.downloadSentDocs(rebuild: true);
                                else
                                  _dataCubit!
                                      .downloadReceivedDocs(rebuild: true);
                                setState(() {});
                              },
                              splashRadius: 20,
                              icon: Icon(
                                Icons.refresh,
                                color: primary,
                              ),
                            );
                    },
                  ),
              ],
            ),
            // listView:-----------------------------------------------------------
            BlocBuilder<DataCubit, DataState>(
              builder: (context, state) {
                // sentDoc state:--------------------------------------------------
                if (state is SentDoc) {
                  if (state.docs == null) {
                    return errorWidget();
                  } else if (state.docs!.isEmpty) {
                    return emptyList();
                  }
                  return Expanded(
                    child: DocTiles(
                      docs: state.docs!,
                      isDesktop: widget.isDesktop,
                      isSent: true,
                    ),
                  );
                }
                // receivedDoc State:-------------------------------------------------------------
                else if (state is ReceivedDoc) {
                  if (state.docs == null) {
                    return errorWidget();
                  } else if (state.docs!.isEmpty) {
                    return emptyList(false);
                  }
                  return Expanded(
                    child: DocTiles(
                      docs: state.docs!,
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
                      EdgeInsets.symmetric(horizontal: 35, vertical: 17)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                onPressed: () {
                  _dataCubit!.downloadReceivedDocs();
                  _dataCubit!.downloadSentDocs();
                  _dataCubit!.emit(Authenticated());
                },
                child: Text("Reload"),
              )
            ],
          ),
        ),
      );

  //Empty list widget:-------------------------------
  Widget emptyList([isSent = true]) => SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: 400,
          child: CircleAvatar(
            radius: double.infinity,
            backgroundColor: Colors.white70,
            child: isSent
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Tap ",
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[600])),
                      SizedBox(height: 8),
                      Icon(Icons.note_add_rounded, color: Colors.grey[600]),
                      SizedBox(height: 8),
                      Text(
                        " to add a document",
                        style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  )
                : Text(
                    "No documents",
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  ),
          ),
        ),
      );

  //BottomNavBar widget:----------------------------
  Widget bottomNavBar() {
    Map<String, dynamic> buttons = {
      "Sent": Icons.send,
      "space": "_",
      "Received": Icons.receipt,
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
                            // bottomNavSelector = map.key;
                            // getDocsByOption();
                            _dataCubit!.bottomNavSelector = map.key;
                            _dataCubit!.optionSel = map.key == "Sent" ? 0 : 1;
                            _dataCubit!.getDocsByOption();
                            _dataCubit!.selectedIndexes = _dataCubit!
                                .selectedIndexes
                                .map((e) => -1)
                                .toList();
                            _desktopNavCubit!.navToHomeScreen();
                            setState(() {});
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                map.value,
                                size: 30,
                                color: _dataCubit!.bottomNavSelector == map.key
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
