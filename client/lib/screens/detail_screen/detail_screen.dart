import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softdoc/cubit/AndroidNav_cubit.dart';
import 'package:softdoc/models/doc.dart';
import 'package:softdoc/screens/detail_screen/approval_progress.dart';

class DetailScreen extends StatefulWidget {
  Doc selectedDoc;
  DetailScreen({Key key, this.selectedDoc}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  AndroidNavCubit _androidNavCubit;

  @override
  void initState() {
    super.initState();
    _androidNavCubit = BlocProvider.of<AndroidNavCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    // selectedDoc = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => _androidNavCubit.navToHomeScreen(),
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  height: 60,
                  // color: Colors.blue,
                  child: Text(widget.selectedDoc.subject,
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w600)),
                ),
              ),
              ApprovalProgress(
                  approvalList: widget.selectedDoc.approvalProgress),
            ],
          ),
        ),
      ),
    );
  }
}
