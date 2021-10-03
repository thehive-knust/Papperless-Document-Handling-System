import 'package:flutter/material.dart';

Future<bool?> confirm(BuildContext context, String _title, String _content) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_title),
          content: Text(_content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text("PROCEED", style: TextStyle(color: Colors.redAccent)),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("CANCEL"))
          ],
        );
      });
}

void showProcessingAlert(context, message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          content: CircularProgressIndicator(),
          contentPadding: EdgeInsets.symmetric(horizontal: 100, vertical: 50),
        );
      });
}

void showMessage(context, {status, message}) {
  showDialog(
      context: context,
      builder: (context) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pop(context);
        });
        return AlertDialog(
          content: message == null
              ? Text(
                  status ? "Operation Successful" : "Operation Failed",
                  style: TextStyle(color: status ? Colors.green : Colors.red),
                )
              : Text(message),
        );
      });
}
