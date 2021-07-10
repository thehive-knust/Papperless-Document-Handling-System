import 'package:flutter/material.dart';
import 'package:softdoc/models/doc.dart';
import 'package:softdoc/screens/detail_screen/approval_progress.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({Key key}) : super(key: key);
  Doc selectedDoc;

  @override
  Widget build(BuildContext context) {
    selectedDoc = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 60,
                // color: Colors.blue,
                child: Text(selectedDoc.subject,
                    style:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.w600)),
              ),
              ApprovalProgress(approvalList: selectedDoc.approvalProgress)
            ],
          ),
        ),
      ),
    );
  }
}
