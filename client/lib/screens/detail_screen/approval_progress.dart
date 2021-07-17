import 'package:flutter/material.dart';
import 'package:softdoc/style.dart';
// import 'package:timeline_tile/timeline_tile.dart';

class ApprovalProgress extends StatelessWidget {
  Map<String, bool> approvalList;
  Color previousColor;
  bool nextIsAsh;

  ApprovalProgress({Key key, this.approvalList}) : super(key: key);

  checkcolor() {
    approvalList.values.forEach((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 80,
      child: approvalList.length == 1
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                progressDot(approvalList.values.first),
                SizedBox(height: 12),
                Text(approvalList.keys.toList()[0]),
              ],
            )
          : Row(
              children: approvalList.entries.map((e) {
                bool isFirst = false;
                bool isLast = false;
                if (approvalList.keys.first == e.key) isFirst = true;
                if (approvalList.keys.last == e.key) isLast = true;
                return Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          progressLine(isFirst: isFirst),
                          progressDot(e.value),
                          progressLine(isLast: isLast),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        e.key,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }

  Widget progressDot(bool isApproved) {
    Color color;
    if (nextIsAsh == true)
      color = Colors.grey[400];
    else if (isApproved == null)
      color = yellow;
    else if (isApproved == true)
      color = green;
    else
      color = red;

    if (color == red || color == yellow) nextIsAsh = true;

    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: Colors.black26, offset: Offset(0.0, 3.0), blurRadius: 4)
        ],
      ),
    );
  }

  Widget progressLine(
      {bool isFirst = false, bool isLast = false, bool start, bool end}) {
    return Expanded(
      child: isFirst || isLast
          ? SizedBox()
          : Container(
              height: 3,
              decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [yellow, Colors.grey.shade300]),
              ),
            ),
    );
  }
}
//
// Stack(
// //alignment: Alignment.topCenter,
// children: [
// // lines:---------------------------------------------------------------------------
// Container(
// width: screenSize.width * 0.74,
// alignment: Alignment.center,
// // margin: EdgeInsets.symmetric(horizontal: 35),
// height: 15,
// child: Row(
// children: [
// Expanded(
// child: Container(
// height: 1.5,
// decoration: BoxDecoration(
// gradient: LinearGradient(colors: [green, yellow])),
// ),
// ),
// Expanded(
// child: Container(
// height: 1.5,
// decoration: BoxDecoration(
// gradient: LinearGradient(
// colors: [yellow, Colors.grey.shade300])),
// ),
// ),
// Expanded(
// child: Container(
// height: 1.5,
// decoration: BoxDecoration(
// gradient: LinearGradient(
// colors: [Colors.grey.shade300, Colors.grey.shade300],
// ),
// ),
// ),
// ),
// ],
// ),
// ),
// // circles:-----------------------------------------------------------------------
// Row(
// // crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Expanded(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Container(
// width: 15,
// height: 15,
// decoration: BoxDecoration(
// color: green,
// shape: BoxShape.circle,
// boxShadow: [
// BoxShadow(
// color: Colors.black26,
// offset: Offset(0.0, 3.0),
// blurRadius: 4)
// ],
// ),
// ),
// SizedBox(height: 3),
// Text(
// "Patron",
// textAlign: TextAlign.center,
// maxLines: 2,
// overflow: TextOverflow.ellipsis,
// )
// ],
// ),
// ),
// Expanded(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Container(
// width: 15,
// height: 15,
// decoration: BoxDecoration(
// color: yellow,
// shape: BoxShape.circle,
// boxShadow: [
// BoxShadow(
// color: Colors.black26,
// offset: Offset(0.0, 3.0),
// blurRadius: 4)
// ],
// ),
// ),
// SizedBox(height: 3),
// Text(
// "HOD",
// textAlign: TextAlign.center,
// )
// ],
// ),
// ),
// Expanded(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Container(
// width: 15,
// height: 15,
// decoration: BoxDecoration(
// color: Colors.grey[300],
// shape: BoxShape.circle,
// boxShadow: [
// BoxShadow(
// color: Colors.black26,
// offset: Offset(0.0, 3.0),
// blurRadius: 4)
// ],
// ),
// ),
// SizedBox(height: 3),
// Text(
// "Registrar",
// textAlign: TextAlign.center,
// )
// ],
// ),
// ),
// Expanded(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Container(
// width: 15,
// height: 15,
// decoration: BoxDecoration(
// color: Colors.grey[300],
// shape: BoxShape.circle,
// boxShadow: [
// BoxShadow(
// color: Colors.black26,
// offset: Offset(0.0, 3.0),
// blurRadius: 4)
// ],
// ),
// ),
// SizedBox(height: 3),
// Text(
// "Student",
// textAlign: TextAlign.center,
// )
// ],
// ),
// ),
// ],
// ),
// ],
// ),

// Container(
// color: Colors.blue,
// width: double.infinity,
// margin: EdgeInsets.symmetric(horizontal: 12),
// height: 100,
// child: Row(
// //mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Expanded(
// child: Container(
// color: Colors.pink,
// //alignment: Alignment.centerLeft,
// child: TimelineTile(
// axis: TimelineAxis.horizontal,
// //alignment: TimelineAlign.start,
// isFirst: true,
// endChild: Text("HOD"),
// ),
// ),
// ),
// Expanded(
// child: TimelineTile(
// axis: TimelineAxis.horizontal,
// //alignment: TimelineAlign.start,
// isFirst: true,
// endChild: Text("HOD"),
// ),
// ),
// Expanded(
// child: TimelineTile(
// axis: TimelineAxis.horizontal,
// //alignment: TimelineAlign.start,
// isLast: true,
// endChild: Text("HOD"),
// ),
// )
// ],
// ),
// )
