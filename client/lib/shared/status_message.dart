import 'package:flutter/material.dart';
import 'package:softdoc/style.dart';

class StatusMessage extends StatelessWidget {
  final String status;
  final bool isDesktop;

  const StatusMessage(this.status, {this.isDesktop = false});

  Color color({bool light = false}) {
    switch (status) {
      case "approved":
        return light ? green.withOpacity(0.3) : green;
      case 'rejected':
        return light ? redLight.withOpacity(0.3) : red;
      case 'cancelled':
        return light ? Colors.grey[200] : Colors.grey[400];
    }
  }

  String text() {
    if (status == "approved")
      return "Approval Complete";
    else if (status == 'cancelled') return "Request Cancelled";
    return "Rejected";
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Container(
        // margin: EdgeInsets.only(top: 12),
        height: isDesktop ? 60 : 60,
        color: color(light: true),
        child: Row(
          children: [
            Container(
              width: 5,
              color: color(),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Container(
                child: Text(
                  text(),
                  style: TextStyle(
                    fontSize: isDesktop ? desktopFontSize : androidFontSize,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}