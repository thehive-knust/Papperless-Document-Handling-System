import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softdoc/cubit/android_nav_cubit/AndroidNav_cubit.dart';
import 'package:softdoc/cubit/desktop_nav_cubit/desktopnav_cubit.dart';
import 'package:softdoc/models/doc.dart';
import 'package:softdoc/screens/home_screen/docTypeIcon.dart';
import 'package:softdoc/style.dart';
import 'package:intl/intl.dart';
import 'approval_progress.dart';

class DetailScreen extends StatefulWidget {
  Doc selectedDoc;
  final bool isDesktop;
  DetailScreen({Key key, this.isDesktop = false, this.selectedDoc})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  AndroidNavCubit _androidNavCubit;
  DesktopNavCubit _desktopNavCubit;

  @override
  void initState() {
    super.initState();
    _androidNavCubit = BlocProvider.of<AndroidNavCubit>(context);
    _desktopNavCubit = BlocProvider.of<DesktopNavCubit>(context);
  }

  void confirmWithdrawal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure?"),
        content: Text("this action is irreversible"),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                widget.selectedDoc.status = 'cancelled';
              });
              Navigator.of(context).pop();
            },
            child: Text(
              "YES",
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("NO"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // selectedDoc = ModalRoute.of(context).settings.arguments;
    return WillPopScope(
      onWillPop: () {
        _androidNavCubit.navToHomeScreen();
        return Future.value(false);
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  height: 60,
                  // color: Colors.blue,
                  child: Text(widget.selectedDoc.subject,
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w600)),
                ),
                if (!widget.isDesktop) ...[
                  SizedBox(height: 10),
                  // ApprovalProgress(
                  //     approvalList: widget.selectedDoc.approvalProgress)
                ],
                Container(
                  // flexible was here
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.selectedDoc.description != null)
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryLight),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.selectedDoc.description,
                                  style: TextStyle(
                                      fontSize: widget.isDesktop ? 20 : 14)),
                              Container(
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white),
                                  padding: EdgeInsets.all(4),
                                  child: Text(DateFormat("d MMMM, y   h:m a")
                                      .format(widget.selectedDoc.createdAt)))
                            ],
                          ),
                        ),
                      Container(
                        height: 200,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Expanded(
                                  child: Container(
                                      color: Colors.white,
                                      child: Icon(Icons.note))),
                              // Thumbnail(
                              //   mimeType: 'application/pdf',
                              //   widgetSize:
                              //       MediaQuery.of(context).size.height * 0.2,
                              //   dataResolver: () async {
                              //     return (await DefaultAssetBundle.of(context)
                              //             .load('assets/sample/thispdf.pdf'))
                              //         .buffer
                              //         .asUint8List();
                              //   },
                              //   useWrapper: true,
                              // ),
                              Container(
                                color: primaryLight,
                                padding: EdgeInsets.all(8),
                                height: 50,
                                child: Row(
                                  children: [
                                    DocTypeIcon(),
                                    SizedBox(width: 10),
                                    //Text(basename())
                                    Text("name of file.pdf"),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      if (widget.selectedDoc.status != "pending")
                        StatusMessage(widget.selectedDoc.status),
                      // Flexible(child: SizedBox(), fit: FlexFit.tight),
                      // if (selectedDoc.status == "pending")
                      //   ElevatedButton(
                      //     onPressed: () => confirmWithdrawal(context),
                      //     child: Text("Cancel request"),
                      //     style: ElevatedButton.styleFrom(
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(8),
                      //       ),
                      //       primary: red,
                      //       minimumSize: Size(300, 50),
                      //       textStyle: TextStyle(fontSize: 20),
                      //     ),
                      //   ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: widget.selectedDoc.status == 'pending'
            ? FloatingActionButton.extended(
                // onPressed: () => confirmWithdrawal(context),
                onPressed: () => widget.isDesktop
                    ? _desktopNavCubit.navToHomeScreen()
                    : _androidNavCubit.navToHomeScreen(),
                label: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Cancel request",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                backgroundColor: red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              )
            : null,
        floatingActionButtonLocation: !widget.isDesktop
            ? FloatingActionButtonLocation.centerFloat
            : FloatingActionButtonLocation.startFloat,
      ),
    );
  }
}

class StatusMessage extends StatelessWidget {
  final String status;
  final bool isDesktop;

  const StatusMessage(this.status, {this.isDesktop = false});

  Color color({bool light = false}) {
    switch (status) {
      case "approved":
        return light ? green.withOpacity(0.3) : green;
      case 'rejected':
        return light ? redLight.withOpacity(0.3) : red;
      case 'cancelled':
        return light ? Colors.grey[200] : Colors.grey[400];
    }
  }

  String text() {
    if (status == "approved")
      return "Approval Complete";
    else if (status == 'cancelled') return "Request Cancelled";
    return "Rejected";
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Container(
        // margin: EdgeInsets.only(top: 12),
        height: isDesktop ? 60 : 60,
        color: color(light: true),
        child: Row(
          children: [
            Container(
              width: 5,
              color: color(),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Container(
                child: Text(
                  text(),
                  style: TextStyle(
                    fontSize: isDesktop ? desktopFontSize : androidFontSize,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
