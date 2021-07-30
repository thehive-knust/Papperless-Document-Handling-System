import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softdoc/cubit/android_nav_cubit/AndroidNav_cubit.dart';
import 'package:softdoc/cubit/data_cubit/data_cubit.dart';
import 'package:softdoc/cubit/desktop_nav_cubit/desktopnav_cubit.dart';
import 'package:softdoc/models/doc.dart';
import 'package:softdoc/style.dart';

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
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 60,
                // color: Colors.blue,
                child: Text(widget.selectedDoc.subject,
                    style:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.w600)),
              ),
              Container(
                height: 150,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                    color: primaryLight,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "From: ",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Portfolio ",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Phone ",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
