import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softdoc/cubit/AndroidNav_cubit.dart';
import 'package:softdoc/models/doc.dart';
import 'package:softdoc/screens/send_doc_screen/add_or_edit_recepient.dart';
import 'package:softdoc/screens/send_doc_screen/select_recepient.dart';
import 'package:softdoc/style.dart';

class SendDocScreen extends StatefulWidget {
  final bool isDesktop;
  SendDocScreen({Key key, this.isDesktop}) : super(key: key);

  @override
  _SendDocScreenState createState() => _SendDocScreenState();
}

class _SendDocScreenState extends State<SendDocScreen> {
  Doc doc;
  AndroidNavCubit _androidNavCubit;

  void changeState() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    doc = Doc();
    _androidNavCubit = BlocProvider.of<AndroidNavCubit>(context);
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
            _androidNavCubit.navToHomeScreen();
          },
          child: Icon(Icons.send),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              children: [
                // subject field here:---------------------------------------------------------------------------
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
                if (!widget.isDesktop) SizedBox(height: 10),
                // selected recepient stuff here:--------------------------------------------------------------
                if (!widget.isDesktop) addOrEditReciepient(false, changeState),
                SizedBox(height: 10),
                // enter description field here:--------------------------------------------------------
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: primaryLight,
                      borderRadius: BorderRadius.circular(10)),
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
                // pick pdf from here:------------------------------------------------------------------
                Container(
                  height: 170,
                  width: double.infinity,
                  child: DottedBorder(
                    dashPattern: [8],
                    color: primary,
                    borderType: BorderType.RRect,
                    radius: Radius.circular(10),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.note, size: 30),
                          SizedBox(height: 20),
                          Text("Upload File"),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
