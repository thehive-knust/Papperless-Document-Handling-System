import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:softdoc/cubit/android_nav_cubit/AndroidNav_cubit.dart';
import 'package:softdoc/cubit/data_cubit/data_cubit.dart';
import 'package:softdoc/cubit/desktop_nav_cubit/desktopnav_cubit.dart';
import 'package:softdoc/models/doc.dart';
import 'package:softdoc/shared/pdf_card.dart';
import 'package:softdoc/shared/status_message.dart';
import 'package:softdoc/shared/time_badge.dart';
import 'package:softdoc/style.dart';

class ReceivedDetailScreen extends StatefulWidget {
  final Doc selectedDoc;
  const ReceivedDetailScreen({Key key, this.selectedDoc}) : super(key: key);

  @override
  _ReceivedDetailScreenState createState() => _ReceivedDetailScreenState();
}

class _ReceivedDetailScreenState extends State<ReceivedDetailScreen> {
  AndroidNavCubit _androidNavCubit;
  DesktopNavCubit _desktopNavCubit;
  DataCubit _dataCubit;

  @override
  void initState() {
    super.initState();
    _androidNavCubit = BlocProvider.of<AndroidNavCubit>(context);
    _desktopNavCubit = BlocProvider.of<DesktopNavCubit>(context);
    _dataCubit = BlocProvider.of<DataCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;
    return WillPopScope(
      onWillPop: () {
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
                          textRow(
                              "From: ", widget.selectedDoc.senderInfo['name']),
                          textRow("Portfolio: ",
                              widget.selectedDoc.senderInfo['title']),
                          textRow("Phone: ",
                              widget.selectedDoc.senderInfo['contact']),
                          timeBadge(widget.selectedDoc.createdAt)
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CircleAvatar(
                        radius: double.infinity,
                        backgroundImage: NetworkImage(
                            widget.selectedDoc.senderInfo['img_url'] ??
                                "https://source.unsplash.com/random"),
                        backgroundColor: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              // pdf card section:-----------------------------------------------------------------
              InkWell(
                onTap: () {
                  isDesktop
                      ? _desktopNavCubit.navToPdfViewer(
                          selectedDoc: widget.selectedDoc,
                          fromReceivedScreen: true)
                      : _androidNavCubit.navToPdfViewer(
                          selectedDoc: widget.selectedDoc,
                          fromReceivedScreen: true);
                },
                child: Container(
                  height: 200,
                  width: double.infinity,
                  child: pdfCard(
                      widget.selectedDoc.filename, widget.selectedDoc.fileUrl),
                ),
              ),
              SizedBox(height: 40),
              // buttons section:-----------------------------------------------------------------
              if (widget.selectedDoc.status == 'pending') ...[
                decitionButtons(true, isDesktop),
                SizedBox(height: 30),
                decitionButtons(false, isDesktop)
              ] else
                StatusMessage(widget.selectedDoc.status)
            ],
          ),
        ),
      ),
    );
  }

  Widget textRow(String p, String txt) => RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
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

  Widget decitionButtons(bool isApproved, isDesktop) => Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        height: 45,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => alertDialog(isApproved, isDesktop),
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(isApproved ? green : red)),
          child: Text(
            isApproved ? "Approve" : "Reject",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      );

  Future<bool> alertDialog(isApproved, isDesktop) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure?"),
        content: Text("this action is irreversible"),
        actions: [
          TextButton(
            onPressed: () async {
              String status = isApproved ? 'approved' : 'rejected';
              EasyLoading.show(
                  status:
                      isApproved ? "Approving document" : "Rejecting document");
              bool success = await _dataCubit.statusUpdate(
                  DataCubit.user.id, widget.selectedDoc.id, status);
              if (success) {
                EasyLoading.showSuccess('Document $status successfully',
                    dismissOnTap: true);
                widget.selectedDoc.status = status;
                widget.selectedDoc.updatedAt = DateTime.now();
                _dataCubit.sortReceivedDocs();
                _dataCubit.getDocsByOption();
                setState(() {});
                Navigator.pop(context);
                isDesktop
                    ? _desktopNavCubit.navToHomeScreen()
                    : _androidNavCubit.navToHomeScreen();
              } else {
                EasyLoading.showError(
                    (isApproved
                        ? "Approval unsuccessful"
                        : "Rejection unsuccessful"),
                    dismissOnTap: true);
                Navigator.pop(context);
              }
            },
            child: Text("YES"),
          ),
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("NO", style: TextStyle(color: Colors.redAccent)))
        ],
      ),
    );
  }
}
