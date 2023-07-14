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
import 'approval_progress.dart';

class DetailScreen extends StatefulWidget {
  final Doc? selectedDoc;
  DetailScreen({Key? key, this.selectedDoc,})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  AndroidNavCubit? _androidNavCubit;
  DesktopNavCubit? _desktopNavCubit;
  DataCubit? _dataCubit;

  @override
  void initState() {
    super.initState();
    _androidNavCubit = BlocProvider.of<AndroidNavCubit>(context);
    _desktopNavCubit = BlocProvider.of<DesktopNavCubit>(context);
    _dataCubit = BlocProvider.of<DataCubit>(context);
  }

  void confirmWithdrawal(BuildContext context, isDesktop) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure?"),
        content: Text("this action will delete this document irreversibly"),
        actions: [
          TextButton(
            onPressed: () async {
              EasyLoading.show(status: "Deleting document");
              bool success = await _dataCubit!.deleteDoc(widget.selectedDoc!.id);
              if (success) {
                EasyLoading.showSuccess("Submission canceled",
                    dismissOnTap: true);
                _dataCubit!.sentDocs!.remove(widget.selectedDoc);
                _dataCubit!.getDocsByOption();
                Navigator.of(context).pop();
                isDesktop
                    ? _desktopNavCubit!.navToHomeScreen()
                    : _androidNavCubit!.navToHomeScreen();
              } else {
                EasyLoading.showError("Document not deleted, try again");
                Navigator.of(context).pop();
              }
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
    final isDesktop = MediaQuery.of(context).size.width > 600;
    return WillPopScope(
      onWillPop: () {
        _androidNavCubit!.navToHomeScreen();
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
                  child: Text(widget.selectedDoc!.subject!!,
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w600)),
                ),
                if (!isDesktop) ...[
                  SizedBox(height: 10),
                  ApprovalProgress(
                    approvalList: widget.selectedDoc!.approvalProgress,
                    docStatus: widget.selectedDoc!.status,
                  )
                ],
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryLight),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (widget.selectedDoc!.description!
                                  .isNotEmpty) // changed it from isNotNull to is not empty
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Text(widget.selectedDoc!.description!,
                                      style: TextStyle(
                                          fontSize: isDesktop ? 20 : 14)),
                                ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: timeBadge(widget.selectedDoc!.createdAt!),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () async {
                          var success = await PdfThumbnail.tryPdfDownload(
                            context,
                            widget.selectedDoc!.fileUrl!,
                            isDesktop,
                          );
                          if (success == null) return;
                          isDesktop
                              ? _desktopNavCubit!.navToPdfViewer(
                                  selectedDoc: widget.selectedDoc,
                                  fromReceivedScreen: false,
                                )
                              : _androidNavCubit!.navToPdfViewer(
                                  selectedDoc: widget.selectedDoc,
                                  fromReceivedScreen: false,
                                );
                        },

                        // {
                        // html.window.open(widget.selectedDoc.fileUrl,
                        //     widget.selectedDoc.filename);
                        //   return Navigator.of(context).push(
                        //     MaterialPageRoute(
                        //       builder: (context) =>
                        //           PdfViewer(url: widget.selectedDoc.fileUrl),
                        //     ),
                        //   );
                        // },
                        child: Container(
                          height: 250,
                          child: PdfCard(
                            name: widget.selectedDoc!.filename!,
                            url: widget.selectedDoc!.fileUrl!,
                            isDesktop: isDesktop,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      if (widget.selectedDoc!.status! != "pending")
                        StatusMessage(widget.selectedDoc!.status!),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: widget.selectedDoc!.status == 'pending'
            ? FloatingActionButton.extended(
                // onPressed: () => confirmWithdrawal(context),
                onPressed: () => confirmWithdrawal(context, isDesktop),

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
        floatingActionButtonLocation: !isDesktop
            ? FloatingActionButtonLocation.centerFloat
            : FloatingActionButtonLocation.startFloat,
      ),
    );
  }
}
