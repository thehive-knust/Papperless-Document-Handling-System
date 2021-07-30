import 'package:flutter/material.dart';
import '../../style.dart';

class VApprovalProgress extends StatefulWidget {
  final Map<String, String> approvalList;
  final String docStatus;
  const VApprovalProgress({Key key, this.approvalList, this.docStatus})
      : super(key: key);

  @override
  _VApprovalProgressState createState() => _VApprovalProgressState();
}

class _VApprovalProgressState extends State<VApprovalProgress> {
  Color previousColor;
  bool nextIsAsh;
  bool lastColoredLine = false;

  @override
  Widget build(BuildContext context) {
    nextIsAsh = false;
    final Size screenSize = MediaQuery.of(context).size;
    List<String> approvalListKeys = widget.approvalList.keys.toList();

    return Center(
      child: Container(
        constraints: BoxConstraints(minHeight: 500),
        padding: EdgeInsets.only(left: screenSize.width * 0.08),
        height: screenSize.height * 0.8,
        child: widget.approvalList.length == 1
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  progressDot(widget.approvalList.values.first),
                  SizedBox(width: 12),
                  Text(approvalListKeys[0]),
                ],
              )
            : Column(
                children: widget.approvalList.entries.map((e) {
                  bool isFirst = false;
                  bool isLast = false;
                  if (approvalListKeys.first == e.key) isFirst = true;
                  if (approvalListKeys.last == e.key) isLast = true;
                  return Expanded(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            progressLine(
                              isFirst: isFirst,
                              start: widget.approvalList[approvalListKeys[
                                  (approvalListKeys.indexOf(e.key) - 1) %
                                      widget.approvalList.length]],
                              end: e.value,
                              beforeLine: true,
                            ),
                            progressDot(e.value),
                            progressLine(
                              isLast: isLast,
                              start: e.value,
                              end: widget.approvalList[approvalListKeys[
                                  (approvalListKeys.indexOf(e.key) + 1) %
                                      widget.approvalList.length]],
                              afterLine: true,
                            ),
                          ],
                        ),
                        SizedBox(width: 12),
                        Text(
                          e.key,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
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

  Widget progressDot(String approvalStatus) {
    Color color;
    if (nextIsAsh == true || widget.docStatus == 'cancelled')
      color = Colors.grey[400];
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

  Color colorMix(Color startColor, Color endColor) {
    return Color.fromARGB(
        (startColor.alpha + endColor.alpha) ~/ 2,
        (startColor.red + endColor.red) ~/ 2,
        (startColor.green + endColor.green) ~/ 2,
        (startColor.blue + endColor.blue) ~/ 2);
  }

  Widget progressLine(
      {bool isFirst = false,
      bool isLast = false,
      String start,
      String end,
      bool beforeLine = false,
      bool afterLine = false}) {
    Color startColor = approvalStateColor(start);
    Color endColor = approvalStateColor(end);

    if (widget.docStatus == 'cancelled')
      startColor = endColor = Colors.grey[400];
    else if (nextIsAsh == true) {
      startColor = lastColoredLine ? startColor : Colors.grey[400];

      if (lastColoredLine) lastColoredLine = false;

      if (afterLine)
        endColor = colorMix(startColor, Colors.grey[400]);
      else {
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
              width: 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [startColor, endColor]),
              ),
            ),
    );
  }
}
