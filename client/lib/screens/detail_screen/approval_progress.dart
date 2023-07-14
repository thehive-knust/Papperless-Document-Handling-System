import 'package:flutter/material.dart';
import 'package:softdoc/style.dart';
// import 'package:timeline_tile/timeline_tile.dart';

class ApprovalProgress extends StatefulWidget {
  final Map<String, String>? approvalList;
  final String? docStatus;

  ApprovalProgress({Key ?key, this.approvalList, this.docStatus})
      : super(key: key);

  @override
  _ApprovalProgressState createState() => _ApprovalProgressState();
}

class _ApprovalProgressState extends State<ApprovalProgress> {
  Color? previousColor;
  bool? nextIsAsh;
  bool lastColoredLine = false;

  @override
  Widget build(BuildContext context) {
    List<String> approvalListKeys = widget.approvalList!.keys.toList();
    return widget.approvalList!.length == 1
        ? IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                progressDot(widget.approvalList!.values.first),
                SizedBox(height: 12),
                Text(approvalListKeys[0]),
              ],
            ),
          )
        : IntrinsicHeight(
            child: Row(
              children: widget.approvalList!.entries.map((e) {
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
                            start: widget.approvalList![approvalListKeys[
                                (approvalListKeys.indexOf(e.key) - 1) %
                                    widget.approvalList!.length]]!,
                            end: e.value,
                            beforeLine: true,
                          ),
                          progressDot(e.value),
                          progressLine(
                            isLast: isLast,
                            start: e.value,
                            end: widget.approvalList![approvalListKeys[
                                (approvalListKeys.indexOf(e.key) + 1) %
                                    widget.approvalList!.length]]!,
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

  Color approvalStateColor(String approvalState) {
    if (approvalState == 'pending')
      return yellow;
    else if (approvalState == 'approved')
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

  Widget progressDot(String approvalStatus) {
    Color color;
    if (nextIsAsh == true || widget.docStatus == 'cancelled')
      color = Colors.grey[400]!;
    else
      color = approvalStateColor(approvalStatus);

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
      String? start,
      String? end,
      bool beforeLine = false,
      bool afterLine = false}) {
    Color startColor = approvalStateColor(start!);
    Color endColor = approvalStateColor(end!);

    if (widget.docStatus == 'cancelled')
      startColor = endColor = Colors.grey[400]!;
    else if (nextIsAsh == true) {
      startColor = lastColoredLine ? startColor : Colors.grey[400]!;

      if (lastColoredLine) lastColoredLine = false;

      if (afterLine)
        endColor = colorMix(startColor, Colors.grey[400]!);
      else {
        startColor = colorMix(startColor, Colors.grey[400]!);
        endColor = Colors.grey[400]!;
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
