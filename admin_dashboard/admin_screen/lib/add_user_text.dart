import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddUserText extends StatelessWidget {
  const AddUserText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 30),
        padding: const EdgeInsets.only(left: 50),
        child: Text(
          'Personal Info',
          style: GoogleFonts.notoSans(
            fontSize: 40,
            fontWeight: FontWeight.w800,
          ),
        ),
      );
  }
}
