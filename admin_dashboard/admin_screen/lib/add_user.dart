import 'dart:convert';

import 'package:admin_screen/repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class Adduser extends StatefulWidget {
  final String title = "Flutter Data Table";
  @override
  _AdduserState createState() => _AdduserState();
}

enum SingingCharacter { Standard, Admin }

class _AdduserState extends State<Adduser> {

  bool _validateEmail = false;

  Repository repo = Repository();

  List<String> faculties = ["Choose your Faculty"];
  List<String> departments = ["Choose .."];
  String selectedFaculty = "Choose your Faculty";
  String selectedDepartment = "Choose ..";



  @override
  void initState() {
    faculties = List.from(faculties)..addAll(repo.getFaculties()!);
    super.initState();
  }

  String dropdownValue1 = 'College of Engineering';

  List<String> collegesForKNUST=[
    "College of Engineering",
    "College of Science",
    "College of Health and Sciences",
    "College of Art and Built Environment",
    "College of Humanities and Social Sciences",
    "College of Agriculture and Natural Resources",
  ];




  TextEditingController? emailController = TextEditingController();
  TextEditingController? firstNameController = TextEditingController();
  TextEditingController? lastNameController = TextEditingController();
  TextEditingController? otherNameController = TextEditingController();
  TextEditingController? associationRoleController = TextEditingController();

  // var counterUsers = [];
  // Uri url = Uri.parse("http://soft-doc.herokuapp.com/auth/signup");
  // Future<void> fetchUsers() async {
  //   const url =
  //       "https://testadmin-c82a8-default-rtdb.firebaseio.com/users.json";
  //   final response = await http.get(Uri.parse(url)).then((response) {
  //     var extractedData = jsonDecode(response.body) as Map<String, dynamic>;
  //     print(extractedData);
  //   });
  // }

  // Future<String> getID() async {
  //   String? key;
  //   const url =
  //       "https://testadmin-c82a8-default-rtdb.firebaseio.com/users.json";
  //   final response = await http.get(Uri.parse(url)).then((response) {
  //     final extracteddata = jsonDecode(response.body) as Map<String, dynamic>;
  //     extracteddata.forEach((key, value) {
  //       if (value['email'] == emailController!.text) {
  //         print("yeah");
  //         key = key.toString();
  //         print(key);
  //       }
  //     });
  //   });
  //   return key!;
  // }

  void _onSelectedState(String value) {
    setState(() {
      selectedDepartment = "Choose ..";
      departments = ["Choose .."];
      selectedFaculty = value;
      departments = List.from(departments)..addAll(repo.getLocalByState(value));
    });
  }

  void _onSelectedLGA(String value) {
    setState(() => selectedDepartment = value);
  }
  Color primaryLight = Color(0xFFEFF7FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: primaryLight,
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
        child:  Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  //
                  Container(
                    padding: EdgeInsets.only(left: 50),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.black,
                      cursorHeight: 25,
                      cursorWidth: 3.2,
                      decoration: InputDecoration(
                          filled: true,
                          labelText: "email",
                          labelStyle: GoogleFonts.notoSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          errorText:
                              _validateEmail ? "email can't be empty" : null,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Container(
                    padding: EdgeInsets.only(left: 50),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.black,
                      cursorHeight: 25,
                      cursorWidth: 3.2,
                      decoration: InputDecoration(
                          filled: true,
                          labelText: "email",
                          labelStyle: GoogleFonts.notoSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          errorText:
                          _validateEmail ? "email can't be empty" : null,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Container(
                    padding: EdgeInsets.only(left: 50),
                    child: DropdownButton<String>(
                      value: dropdownValue1,
                      icon: const Icon(Icons.arrow_drop_down_sharp),
                      iconSize: 24,
                      elevation: 16,
                      isExpanded: true,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        width: 20,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue1 = newValue!;
                        });
                      },
                      items: collegesForKNUST
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),

                        );
                      }).toList(),
                    )
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 50),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.black,
                      cursorHeight: 25,
                      cursorWidth: 3.2,
                      decoration: InputDecoration(
                          filled: true,
                          labelText: "email",
                          labelStyle: GoogleFonts.notoSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          errorText:
                          _validateEmail ? "email can't be empty" : null,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Container(
                    padding: EdgeInsets.only(left: 50),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.black,
                      cursorHeight: 25,
                      cursorWidth: 3.2,
                      decoration: InputDecoration(
                          filled: true,
                          labelText: "email",
                          labelStyle: GoogleFonts.notoSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          errorText:
                          _validateEmail ? "email can't be empty" : null,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Container(
                    padding: EdgeInsets.only(left: 50),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      items: faculties.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (value) => _onSelectedState(value!),
                      value: selectedFaculty,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 50),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.black,
                      cursorHeight: 25,
                      cursorWidth: 3.2,
                      decoration: InputDecoration(
                          filled: true,
                          labelText: "email",
                          labelStyle: GoogleFonts.notoSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          errorText:
                          _validateEmail ? "email can't be empty" : null,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Container(
                    padding: EdgeInsets.only(left: 50),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.black,
                      cursorHeight: 25,
                      cursorWidth: 3.2,
                      decoration: InputDecoration(
                          filled: true,
                          labelText: "email",
                          labelStyle: GoogleFonts.notoSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          errorText:
                          _validateEmail ? "email can't be empty" : null,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Container(
                    padding: EdgeInsets.only(left: 50),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      items: departments.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      // onChanged: (value) => print(value),
                      onChanged: (value) => _onSelectedLGA(value!),
                      value: selectedDepartment,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}





