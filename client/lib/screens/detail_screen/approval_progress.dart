import 'package:flutter/material.dart';
import 'package:softdoc/style.dart';
// import 'package:timeline_tile/timeline_tile.dart';

class ApprovalProgress extends StatelessWidget {
  Map<String, bool> approvalList;
  Color previousColor;
  bool nextIsAsh;
  bool lastColoredLine = false;

  ApprovalProgress({Key key, this.approvalList}) : super(key: key);

  checkcolor() {
    approvalList.values.forEach((value) {});
  }

  @override
  Widget build(BuildContext context) {
    List<String> approvalListKeys = approvalList.keys.toList();
    return Container(
      alignment: Alignment.topCenter,
      height: 80,
      child: approvalList.length == 1
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                progressDot(approvalList.values.first),
                SizedBox(height: 12),
                Text(approvalListKeys[0]),
              ],
            )
          : Row(
              children: approvalList.entries.map((e) {
                bool isFirst = false;
                bool isLast = false;
                if (approvalListKeys.first == e.key) isFirst = true;
                if (approvalListKeys.last == e.key) isLast = true;
                return Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          progressLine(
                            isFirst: isFirst,
                            start: approvalList[approvalListKeys[
                                (approvalListKeys.indexOf(e.key) - 1) %
                                    approvalList.length]],
                            end: e.value,
                            beforeLine: true,
                          ),
                          progressDot(e.value),
                          progressLine(
                            isLast: isLast,
                            start: e.value,
                            end: approvalList[approvalListKeys[
                                (approvalListKeys.indexOf(e.key) + 1) %
                                    approvalList.length]],
                            afterLine: true,
                          ),
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

  Color approvalStateColor(bool approvalState) {
    if (approvalState == null)
      return yellow;
    else if (approvalState == true)
      return green;
    else
      return red;
  }

  Color colorMix(Color startColor, Color endColor) {
    return Color.fromRGBO(
        (startColor.red + endColor.red) ~/ 2,
        (startColor.green + endColor.green) ~/ 2,
        (startColor.blue + endColor.blue) ~/ 2,
        (startColor.opacity + endColor.opacity) / 2);
  }

  Widget progressDot(bool isApproved) {
    Color color;
    if (nextIsAsh == true)
      color = Colors.grey[400];
    else
      color = approvalStateColor(isApproved);

    if (color == red || color == yellow) {
      nextIsAsh = true;
      lastColoredLine = true;
    }

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
      {bool isFirst = false,
      bool isLast = false,
      bool start,
      bool end,
      bool beforeLine = false,
      bool afterLine = false}) {
    Color startColor = approvalStateColor(start);
    Color endColor = approvalStateColor(end);

    if (nextIsAsh == true) {
      startColor =
          lastColoredLine ? approvalStateColor(start) : Colors.grey[400];

      if (lastColoredLine) lastColoredLine = false;

      if (afterLine) endColor = colorMix(startColor, Colors.grey[400]);
      if (beforeLine) {
        startColor = colorMix(startColor, Colors.grey[400]);
        endColor = Colors.grey[400];
      }
    } else if (beforeLine)
      startColor = colorMix(startColor, endColor);
    else if (afterLine) endColor = colorMix(startColor, endColor);

    return Expanded(
      child: isFirst || isLast
          ? SizedBox()
          : Container(
              height: 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [startColor, endColor]),
              ),
            ),
    );
  }
}
