import 'package:flutter/material.dart';
import 'package:softdoc/style.dart';

class ApprovalProgress extends StatelessWidget {
  Map<String, bool> approvalList;
  ApprovalProgress({Key key, this.approvalList}) : super(key: key);

  checkColor() {}

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: 100,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // lines:---------------------------------------------------------------------------
          Container(
            width: screenSize.width * 0.74,
            alignment: Alignment.center,
            // margin: EdgeInsets.symmetric(horizontal: 35),
            height: 15,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1.5,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [green, yellow])),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1.5,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [yellow, Colors.grey.shade300])),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.grey.shade300, Colors.grey.shade300],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // circles:-----------------------------------------------------------------------
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: green,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 3.0),
                              blurRadius: 4)
                        ],
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "Patron",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: yellow,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 3.0),
                              blurRadius: 4)
                        ],
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "HOD",
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 3.0),
                              blurRadius: 4)
                        ],
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "Registrar",
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 3.0),
                              blurRadius: 4)
                        ],
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "Student",
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
