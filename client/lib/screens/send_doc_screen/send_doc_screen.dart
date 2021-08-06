// import 'dart:html';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softdoc/cubit/android_nav_cubit/AndroidNav_cubit.dart';
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
  Uint8List bytes;
  String filename;
  File pdf;

  void changeState() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    doc = Doc();
    _androidNavCubit = BlocProvider.of<AndroidNavCubit>(context);
    _desktopNavCubit = BlocProvider.of<DesktopNavCubit>(context);
  }

  void pickFile() async {
    FilePickerResult result = await FilePickerWeb.platform
        .pickFiles(allowedExtensions: ['pdf'], type: FileType.custom);

    if (result != null) {
      bytes = result.files.single.bytes;
      filename = result.files.single.name;
      // pdf = File(bytes, filename);
      pdf = File.fromRawPath(bytes);
      setState(() {});
    } else {
      debugPrint('file not found');
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
            widget.isDesktop
                ? _desktopNavCubit.navToHomeScreen()
                : _androidNavCubit.navToHomeScreen();
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
                      child: pdf == null
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
                          : pdfCard(filename)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
