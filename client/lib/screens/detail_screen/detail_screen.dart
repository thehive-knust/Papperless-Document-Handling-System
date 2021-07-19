import 'package:flutter/material.dart';
import 'package:softdoc/models/doc.dart';
import 'package:softdoc/screens/home_screen/docTypeIcon.dart';
import 'package:softdoc/style.dart';
import 'package:intl/intl.dart';
import 'package:thumbnailer/thumbnailer.dart';

import 'approval_progress.dart';

class DetailScreen extends StatefulWidget {
  final bool isDesktop;
  DetailScreen({Key key, this.isDesktop = false}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Doc selectedDoc;

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
                selectedDoc.status = 'cancelled';
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
    selectedDoc = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: 20),
                width: double.infinity,
                height: 60,
                // color: Colors.blue,
                child: Text(selectedDoc.subject,
                    style:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.w600)),
              ),
              ApprovalProgress(approvalList: selectedDoc.approvalProgress),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primaryLight),
                        child: selectedDoc.description != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(selectedDoc.description,
                                      style: TextStyle(
                                          fontSize:
                                              widget.isDesktop ? 20 : 14)),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white),
                                    padding: EdgeInsets.all(4),
                                    child: Text(DateFormat("d MMMM, y   h:m a")
                                        .format(selectedDoc.timeCreated)),
                                  )
                                ],
                              )
                            : SizedBox(),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Thumbnail(
                              mimeType: 'application/pdf',
                              widgetSize:
                                  MediaQuery.of(context).size.height * 0.2,
                              dataResolver: () async {
                                return (await DefaultAssetBundle.of(context)
                                        .load('assets/sample/thispdf.pdf'))
                                    .buffer
                                    .asUint8List();
                              },
                              useWrapper: true,
                            ),
                            Container(
                              color: primaryLight,
                              padding: EdgeInsets.all(8),
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
                      if (selectedDoc.status != "pending")
                        StatusMessage(selectedDoc.status),
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
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => confirmWithdrawal(context),
        label: Text(
          "Cancel request",
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      floatingActionButtonLocation: !widget.isDesktop
          ? FloatingActionButtonLocation.centerFloat
          : FloatingActionButtonLocation.endFloat,
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
        return light ? green.withOpacity(0.5) : green;
      case 'rejected':
        return light ? redLight : red;
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
    return Container(
      margin: EdgeInsets.only(top: 12),
      height: isDesktop ? 60 : 60,
      decoration: BoxDecoration(
        color: color(light: true),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              color: color(),
            ),
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
    );
  }
}
