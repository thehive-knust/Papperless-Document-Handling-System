import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:softdoc/style.dart';

class SendDocScreen extends StatelessWidget {
  const SendDocScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        onPressed: () {},
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
              SizedBox(height: 10),
              // selected recepient stuff here:--------------------------------------------------------------
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryLight,
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    GestureDetector(
                      child: DottedBorder(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        color: primary.withOpacity(0.6),
                        borderType: BorderType.RRect,
                        radius: Radius.circular(6),
                        dashPattern: [5],
                        child: Container(
                          height: 35,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Add or edit recepient(s)",
                                style: TextStyle(color: Colors.black38),
                              ),
                              Icon(Icons.add, color: primary)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
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
    );
  }
}
