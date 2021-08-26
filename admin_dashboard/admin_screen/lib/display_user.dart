import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(Display());

class Display extends StatefulWidget {
  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  bool ascending = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
          sortColumnIndex: 3,
          sortAscending: ascending,
          columnSpacing: 100,
          columns: <DataColumn>[
            DataColumn(
              label: Text(
                'Full Name',
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Role',
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Email',
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Time',
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
              onSort: (columnIndex, ascending) {
                setState(() {
                  this.ascending = ascending;
                });
              },
            ),
            DataColumn(
              label: Text(
                'Remove',
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.red.shade400,
                ),
              ),
            ),
          ],
          rows: <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(Text('Sarah Baba')),
                DataCell(Text('ACES President')),
                DataCell(Text('sarahbaba@gmail.com')),
                DataCell(Text('1st July, 2020')),
                DataCell(IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: Colors.red.shade400,),
                  splashColor: Colors.red.shade200,
                )),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('Angelina Fufuo')),
                DataCell(Text('Secretary')),
                DataCell(Text('angelina@gmail.com')),
                DataCell(Text('2st July, 2020')),
                DataCell(IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: Colors.red.shade400,),
                  splashColor: Colors.red.shade200,
                )),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('Obed Ansah')),
                DataCell(Text('HOD')),
                DataCell(Text('fjsnfnj@gmail.com')),
                DataCell(Text('7st July, 2020')),
                DataCell(IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: Colors.red.shade400,),
                  splashColor: Colors.red.shade200,
                )),
              ],
            ),
          ]),
    );
  }
}
