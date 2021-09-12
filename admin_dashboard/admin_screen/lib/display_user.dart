import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(Display());

class Display extends StatefulWidget {
  @override
  DisplayState createState() => DisplayState();
}

class DisplayState extends State<Display> {

  List<DataRow> rowList = [];

  void addRow() {
    setState(() {
      rowList.add(DataRow(
        cells: <DataCell>[
          DataCell(Text('Angelina')),
          DataCell(Text('Fufuo')),
          DataCell(Text('angelina@gmail.com')),
          DataCell(IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.delete,
              color: Colors.red.shade400,
            ),
            splashColor: Colors.red.shade200,
          )),
        ],
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            sortColumnIndex: 3,
            columnSpacing: 100,
            columns: <DataColumn>[
              DataColumn(
                label: Text(
                  'First Name',
                ),
              ),
              DataColumn(
                label: Text(
                  'Last Name',
                ),
              ),
              DataColumn(
                label: Text(
                  'Email',
                ),
              ),
            DataColumn(
                label: Text(
                  'Remove',
                ),
              ),
            ],
            rows: rowList));
  }
}
