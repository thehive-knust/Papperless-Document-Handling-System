import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softdoc/cubit/android_nav_cubit/AndroidNav_cubit.dart';
import 'package:softdoc/cubit/data_cubit/data_cubit.dart';
import 'package:softdoc/cubit/desktop_nav_cubit/desktopnav_cubit.dart';
import 'package:softdoc/models/doc.dart';
import 'package:softdoc/shared/pdf_card.dart';
import 'package:softdoc/shared/time_badge.dart';
import 'package:softdoc/style.dart';
import 'package:softdoc/screens/detail_screen/detail_screen.dart';

class ReveivedDetailScreen extends StatefulWidget {
  final Doc selectedDoc;
  final bool isDesktop;
  const ReveivedDetailScreen({Key key, this.selectedDoc, this.isDesktop})
      : super(key: key);

  @override
  _ReveivedDetailScreenState createState() => _ReveivedDetailScreenState();
}

class _ReveivedDetailScreenState extends State<ReveivedDetailScreen> {
  AndroidNavCubit _androidNavCubit;
  DesktopNavCubit _desktopNavCubit;
  DataCubit _dataCubit;

  @override
  void initState() {
    super.initState();
    _androidNavCubit = BlocProvider.of<AndroidNavCubit>(context);
    _desktopNavCubit = BlocProvider.of<DesktopNavCubit>(context);
    _dataCubit = BlocProvider.of<DataCubit>(context);
    // request for doc details.
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // TODO: nav to previous state
        _androidNavCubit.navToHomeScreen();
        return Future.value(false);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                // subject section:------------------------------------------------------
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 60,
                // color: Colors.blue,
                child: Text(widget.selectedDoc.subject,
                    style:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.w600)),
              ),
              Container(
                // user info section:----------------------------------------------------
                height: 150,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: primaryLight,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textRow("From: ", widget.selectedDoc.senderInfo['name']),
                          textRow("Portfolio: ", widget.selectedDoc.senderInfo['title']),
                          textRow("Phone: ", widget.selectedDoc.senderInfo['contact']),
                          timeBadge(widget.selectedDoc.createdAt)
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CircleAvatar(
                        radius: double.infinity,
                        backgroundColor: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              // pdf card section:-----------------------------------------------------------------
              GestureDetector(
                onTap: () => DetailScreen.downloadPDF(
                    widget.selectedDoc.fileUrl ??
                        'http://africau.edu/images/default/sample.pdf'),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  child: pdfCard(widget.selectedDoc.filename),
                ),
              ),
              SizedBox(height: 40),
              // buttons section:-----------------------------------------------------------------
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // call approve api here:
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(green)),
                  child: Text(
                    "Approve",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // call reject api here
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(red)),
                  child: Text(
                    "Reject",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textRow(String p, String txt) => RichText(
        text: TextSpan(
          text: p,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          children: [
            TextSpan(
              text: txt,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black.withOpacity(0.9),
              ),
            )
          ],
        ),
      );
}
