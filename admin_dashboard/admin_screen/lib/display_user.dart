import 'dart:ui';

import 'package:admin_screen/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() => runApp(Display());

class Display extends StatefulWidget {
  @override
  DisplayState createState() => DisplayState();
}

class DisplayState extends State<Display> {
  // List<DataRow> rowList;
  //
  // void addRow() {
  //   setState(() {
  //     rowList.add(DataRow(
  //       cells: <DataCell>[
  //         DataCell(Text('Angelina')),
  //         DataCell(Text('Fufuo')),
  //         DataCell(Text('angelina@gmail.com')),
  //         DataCell(IconButton(
  //           onPressed: () {},
  //           icon: Icon(
  //             Icons.delete,
  //             color: Colors.red.shade400,
  //           ),
  //           splashColor: Colors.red.shade200,
  //         )),
  //       ],
  //     ));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Selector<UsersProvider, List<DataRow>>(
            selector: (context, provider) => provider.rowList!,
            builder: (context, rowList, child) {
              return DataTable(
                sortColumnIndex: 3,
                columnSpacing: 150,
                columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      'First Name',
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Last Name',
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Email',
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Remove',
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
                rows: rowList,
              );
            },
          ),
        ));
  }
}
