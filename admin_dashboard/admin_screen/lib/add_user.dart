import 'dart:convert';

import 'package:flutter/material.dart';
import 'add_user_text.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class Adduser extends StatefulWidget {
  final String title = "Flutter Data Table";
  @override
  _AdduserState createState() => _AdduserState();
}

enum SingingCharacter { Standard, Admin }

class _AdduserState extends State<Adduser> {
  SingingCharacter? _character = SingingCharacter.Standard;

  bool _validateEmail = false;
  bool _validateFirstName = false;
  bool _validateLastName = false;

  String dropdownValue1 = 'Department of Computer Engineering';
  String dropdownValue2 = 'Faculty of Electrical';
  String dropdownValue3 = 'COE';

  TextEditingController? emailController = TextEditingController();
  TextEditingController? firstNameController = TextEditingController();
  TextEditingController? lastNameController = TextEditingController();
  TextEditingController? otherNameController = TextEditingController();
  TextEditingController? associationRoleController = TextEditingController();

  var counterUsers = [];
  Uri url = Uri.parse("http://soft-doc.herokuapp.com/auth/signup");
  Future<void> fetchUsers() async {
    const url =
        "https://testadmin-c82a8-default-rtdb.firebaseio.com/users.json";
    final response = await http.get(Uri.parse(url)).then((response) {
      var extractedData = jsonDecode(response.body) as Map<String, dynamic>;
      print(extractedData);
    });
  }

  Future<String> getID() async {
    String? key;
    const url =
        "https://testadmin-c82a8-default-rtdb.firebaseio.com/users.json";
    final response = await http.get(Uri.parse(url)).then((response) {
      final extracteddata = jsonDecode(response.body) as Map<String, dynamic>;
      extracteddata.forEach((key, value) {
        if (value['email'] == emailController!.text) {
          print("yeah");
          key = key.toString();
          print(key);
        }
      });
    });
    return key!;
  }

  Future<void> removeUser(String id) async {
    id = getID().toString();
    http.delete(Uri.parse(
        "https://testadmin-c82a8-default-rtdb.firebaseio.com/users/$id.json"));
    print("Deleted");
  }

  Future<void> saveUser() async {
    const url =
        'https://testadmin-c82a8-default-rtdb.firebaseio.com/users.json';
    final response = await http
        .post(Uri.parse(url),
            body: jsonEncode({
              "firstName": firstNameController!.text,
              "lastName": lastNameController!.text,
              "otherName": otherNameController!.text,
              "email": emailController!.text,
              "role": associationRoleController!.text,
            }))
        .then((response) {
      print(jsonDecode(response.body));
    });
  }

  clearValues() {}
  bool isRow= true;
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
                      value: dropdownValue3,
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
                          dropdownValue3 = newValue!;
                        });
                      },
                      items: <String>['COE', 'COHSS', 'COS', 'CANR']
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
                          dropdownValue1= newValue!;
                        });
                      },
                      items: <String>['Department of Computer Engineering', 'Department of Biomedical Engineering']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),

                        );
                      }).toList(),
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
                      value: dropdownValue2,
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
                          dropdownValue2 = newValue!;
                        });
                      },
                      items: <String>['Faculty of Electrical', 'Department of Biomedical Engineering']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),

                        );
                      }).toList(),
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

// Expanded(
// flex: 3,
// child: Container(
// //margin: EdgeInsets.only(right: 20),
// padding: const EdgeInsets.fromLTRB(50.0, 0, 1000, 0),
// child: TextField(
// // controller: lastNameController,
// cursorColor: Colors.black,
// cursorHeight: 30,
// cursorWidth: 3.2,
// obscureText: true,
// decoration: InputDecoration(
// filled: true,
// labelText: "password",
// labelStyle: GoogleFonts.notoSans(
// fontSize: 15,
// fontWeight: FontWeight.w600,
// ),
// // errorText: _validateLastName
// //     ? "las can't be empty"
// //     : null,
// fillColor: Colors.grey[200],
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(7),
// borderSide: BorderSide.none,
// )),
// ),
// ),
// ),

//
//
// // SizedBox(height: 10,),
// Expanded(
// flex: 2,
// child: Container(
// margin: const EdgeInsets.only(right: 1000.0),
// padding: const EdgeInsets.only(left: 50),
// child: TextField(
// controller: associationRoleController,
// cursorColor: Colors.black,
// cursorHeight: 25,
// cursorWidth: 3.2,
// decoration: InputDecoration(
// labelText: 'Association Role',
// labelStyle: GoogleFonts.notoSans(
// fontSize: 15,
// fontWeight: FontWeight.w600,
// ),
// filled: true,
// fillColor: Colors.grey[200],
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(7),
// borderSide: BorderSide.none,
// )),
// ),
// ),
// ),
// Expanded(
// flex: 2,
// child: Column(
// children: <Widget>[
// Container(
// padding: EdgeInsets.only(left: 50),
// child: RadioListTile<SingingCharacter>(
// title: Text(
// 'Standard',
// style: GoogleFonts.notoSans(
// fontSize: 20,
// fontWeight: FontWeight.w800,
// ),
// ),
// value: SingingCharacter.Standard,
// groupValue: _character,
// onChanged: (SingingCharacter? value) {
// setState(() {
// _character = value;
// });
// },
// ),
// ),
// Expanded(
// flex: 5,
// child: Container(
// padding: EdgeInsets.only(left: 50),
// child: RadioListTile<SingingCharacter>(
// title: Text(
// 'Admin',
// style: GoogleFonts.notoSans(
// fontSize: 20,
// fontWeight: FontWeight.w800,
// ),
// ),
// value: SingingCharacter.Admin,
// groupValue: _character,
// activeColor: Colors.green,
// onChanged: (SingingCharacter? value) {
// setState(() {
// _character = value;
// });
// },
// ),
// ),
// ),
// ],
// ),
// ),

/*

 AddUserText(),
              //Spacer(),
              SizedBox(
                height: 40,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(50.0, 0, 1000, 0),
                  child: TextField(
                    controller: otherNameController,
                    cursorColor: Colors.black,
                    cursorHeight: 25,
                    cursorWidth: 3.2,
                    decoration: InputDecoration(
                        labelText: "ID",
                        labelStyle: GoogleFonts.notoSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide.none,
                        )),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(50.0, 0, 350, 0),
                        child: TextField(
                          controller: firstNameController,
                          keyboardType: TextInputType.name,
                          cursorColor: Colors.black,
                          cursorHeight: 25,
                          cursorWidth: 3.2,
                          decoration: InputDecoration(
                              labelText: "First Name",
                              labelStyle: GoogleFonts.notoSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                              filled: true,
                              errorText: _validateFirstName
                                  ? "first name can't be empty"
                                  : null,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide.none,
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        //margin: EdgeInsets.only(right: 20),
                        padding: const EdgeInsets.fromLTRB(5.0, 0, 500, 0),
                        child: TextField(
                          controller: lastNameController,
                          cursorColor: Colors.black,
                          cursorHeight: 30,
                          cursorWidth: 3.2,
                          decoration: InputDecoration(
                              filled: true,
                              labelText: "Last Name",
                              labelStyle: GoogleFonts.notoSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                              errorText: _validateLastName
                                  ? "last name can't be empty"
                                  : null,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide.none,
                              )),
                        ),
                      ),
                    ),
                    // Spacer(
                    //   flex: 2,
                    // ),

                  ],
                ),
              ),

              Expanded(
                flex: 3,
                child: Container(
                  //margin: EdgeInsets.only(right: 20),
                  padding: const EdgeInsets.fromLTRB(50.0, 0, 1000, 0),
                  child: TextField(
                    // controller: lastNameController,
                    cursorColor: Colors.black,
                    cursorHeight: 30,
                    cursorWidth: 3.2,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        filled: true,
                        labelText: "contact",
                        labelStyle: GoogleFonts.notoSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        // errorText: _validateLastName
                        //     ? "las can't be empty"
                        //     : null,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide.none,
                        )),
                  ),
                ),
              ),

 */

/*


  Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 50),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Clear",
                          style: GoogleFonts.notoSans(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        style: ButtonStyle(
                          shape: ButtonStyleButton.allOrNull<OutlinedBorder>(
                              StadiumBorder()),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 5,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 50),
                      child: ElevatedButton(
                        onPressed: () {
                            saveUser();
                        },
                        child: Text(
                          "Save",
                          style: GoogleFonts.notoSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        style: ButtonStyle(
                          shape: ButtonStyleButton.allOrNull<OutlinedBorder>(
                              StadiumBorder()),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
 */
