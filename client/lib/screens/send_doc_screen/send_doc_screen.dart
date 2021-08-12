import 'dart:html';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:softdoc/cubit/android_nav_cubit/AndroidNav_cubit.dart';
import 'package:softdoc/cubit/data_cubit/data_cubit.dart';
import 'package:softdoc/cubit/desktop_nav_cubit/desktopnav_cubit.dart';
import 'package:softdoc/models/doc.dart';
import 'package:softdoc/screens/send_doc_screen/add_or_edit_recepient.dart';
import 'package:softdoc/shared/pdf_card.dart';
import 'package:softdoc/style.dart';

class SendDocScreen extends StatefulWidget {
  final bool isDesktop;
  SendDocScreen({Key key, this.isDesktop = false}) : super(key: key);

  @override
  _SendDocScreenState createState() => _SendDocScreenState();
}

class _SendDocScreenState extends State<SendDocScreen> {
  Doc doc;
  AndroidNavCubit _androidNavCubit;
  DesktopNavCubit _desktopNavCubit;
  DataCubit _dataCubit;

  void changeState() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _androidNavCubit = BlocProvider.of<AndroidNavCubit>(context);
    _desktopNavCubit = BlocProvider.of<DesktopNavCubit>(context);
    _dataCubit = BlocProvider.of<DataCubit>(context);
    doc = Doc();
  }

  void pickFile() async {
    FilePickerResult result = await FilePickerWeb.platform
        .pickFiles(allowedExtensions: ['pdf'], type: FileType.custom);

    if (result != null) {
      doc.fileBytes = result.files.single.bytes;
      doc.filename = result.files.single.name;
      // pdf = File.fromRawPath(bytes);
      setState(() {});
    } else {
      debugPrint('file not found');
    }
  }

  void uploadDoc() async {
    if (doc.subject == null || doc.subject.isEmpty) {
      EasyLoading.showInfo('please enter subject before uploading',
          dismissOnTap: true);
    } else if (DataCubit.approvals.isEmpty) {
      EasyLoading.showInfo('please add recipient(s) before sending',
          dismissOnTap: true);
    } else if (doc.fileBytes == null) {
      EasyLoading.showInfo("please pick a pdf file before sending",
          dismissOnTap: true);
    } else {
      doc.senderId = DataCubit.user.id;
      doc.approvalProgress = {};
      DataCubit.approvals.forEach((id) {
        doc.approvalProgress.putIfAbsent(id, () => 'pending');
      });
      print(doc.approvalProgress.toString());
      EasyLoading.show(status: "Uploading document");
      bool success = await _dataCubit.uploadDoc(doc);
      if (success) {
        EasyLoading.showSuccess("Upload successful");
        DataCubit.approvals.clear();
        widget.isDesktop
            ? _desktopNavCubit.navToHomeScreen()
            : _androidNavCubit.navToHomeScreen();
        _dataCubit.downloadDocs();
      } else {
        EasyLoading.showError('Upload unsuccessful');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _androidNavCubit.navToHomeScreen();
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          backgroundColor: primary,
          onPressed: () {
            uploadDoc();

            // call api to post this document.
          },
          child: Icon(Icons.send),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              children: [
                // subject field here:-----------------------------------------------------------------
                Container(
                  height: 50,
                  child: TextField(
                    onChanged: (val) => doc.subject = val,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: primaryLight,
                      hintText: "Subject",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                // selected recepient stuff here:--------------------------------------------------------------
                if (!widget.isDesktop) ...[
                  SizedBox(height: 10),
                  addOrEditReciepient(false, changeState)
                ],
                SizedBox(height: 10),
                // enter description field here:--------------------------------------------------------
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: primaryLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    onChanged: (val) => doc.description = val,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: "Enter description",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // pick pdf from here:--------------------------------------------------------
                InkWell(
                  onTap: pickFile,
                  child: Container(
                      height: 200,
                      width: double.infinity,
                      child: doc.filename == null
                          ? DottedBorder(
                              dashPattern: [8],
                              color: primary,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(10),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        "assets/images/pdf_icon_deactivated.png",
                                        height: 100,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Text("Upload File"),
                                  ],
                                ),
                              ),
                            )
                          : pdfCard(doc.filename)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
