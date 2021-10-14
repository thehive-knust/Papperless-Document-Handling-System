import 'dart:convert';
import 'package:admin_screen/widgets/AdminUser.dart';

import '../providers/users_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class Adduser extends StatefulWidget {
  final String title = "Flutter Data Table";

  @override
  _AdduserState createState() => _AdduserState();
}

enum SingingCharacter { Standard, Admin }

class _AdduserState extends State<Adduser> {
  bool fetchingDepartments = false;
  bool fetchingPortfolios = false;
  bool fetchingFaculties = false;
  String? selectedFaculty;
  String? selectedDepartment;
  String? selectedPortfolio;
  Map<String, dynamic>? departments;
  Map<String, dynamic>? portfolios;
  List<dynamic>? faculties;
  Uri url = Uri.parse("https://soft-doc.herokuapp.com/auth/signup");
  Color primaryLight = Color(0xFFEFF7FF);
  PlatformFile? image;

  TextEditingController? userIDController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? firstNameController = TextEditingController();
  TextEditingController? lastNameController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? contactNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDepartments();
    fetchPortfolios();
    fetchFaculties();
  }

  Future<void> fetchDepartments() async {
    try {
      const url = "https://soft-doc.herokuapp.com/departments/get/COE";
      fetchingDepartments = true;
      final response = await http.get(Uri.parse(url));
      departments = jsonDecode(response.body);
      fetchingDepartments = false;
      setState(() {
        selectedDepartment = departments!['departments'][0]['id'].toString();
        //selectedFaculty = departments!["departments"][0]['faculty_id'].toString();
      });
    } catch (e) {
      fetchingDepartments = false;
    }
  }

  Future<void> fetchPortfolios() async {
    try {
      const url = "https://soft-doc.herokuapp.com/portfolios";
      fetchingPortfolios = true;
      final response = await http.get(Uri.parse(url));
      portfolios = jsonDecode(response.body);
      fetchingPortfolios = false;
      setState(() {
        selectedPortfolio = portfolios!['portfolios'][0]['id'].toString();
      });
    } catch (e) {
      fetchingPortfolios = false;
    }
    // return response.body as Map<String, dynamic>;
  }

  Future<void> fetchFaculties() async {
    try {
      const url = "https://soft-doc.herokuapp.com/faculties/college/COE";
      fetchingFaculties = true;
      final response = await http.get(Uri.parse(url));
      faculties = jsonDecode(response.body);
      fetchingFaculties = false;
      setState(() {
        selectedFaculty = faculties![0]['id'].toString();
      });
    } catch (e) {
      fetchingFaculties = false;
    }
    // return response.body as Map<String, dynamic>;
  }

  Future<int> submit() async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://soft-doc.herokuapp.com/auth/signup'));
      request.fields.addAll({
        "id": userIDController!.text,
        "first_name": firstNameController!.text,
        "last_name": lastNameController!.text,
        "email": emailController!.text,
        "contact": contactNameController!.text,
        "password": passwordController!.text,
        "faculty_id": selectedFaculty!,
        "department_id": selectedDepartment!,
        "portfolio_id": selectedPortfolio!,
      });
      request.files.add(http.MultipartFile.fromBytes(
          'user_img', image!.bytes!.toList(),
          filename: image!.name));
      var response = await request.send();
      return response.statusCode;
    } catch (e) {
      return 0;
    }
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  uploadImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'svg', 'jpeg']);

    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        image = file;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    if (portfolios == null && !fetchingPortfolios) fetchPortfolios();
    if (departments == null && !fetchingDepartments) fetchDepartments();
    if (faculties == null && !fetchingFaculties) fetchFaculties();
    final usersProvider = Provider.of<UsersProvider>(context);
    return Scaffold(
      backgroundColor: primaryLight,
      body: Container(
        padding: EdgeInsets.fromLTRB(100, 100, 100, 0),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        //
                        Container(
                          padding: EdgeInsets.only(left: 50),
                          child: TextField(
                            controller: userIDController,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            cursorHeight: 25,
                            cursorWidth: 3.2,
                            decoration: InputDecoration(
                                filled: true,
                                labelText: "User ID",
                                labelStyle: GoogleFonts.notoSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                // errorText:
                                //     _validateEmail ? "email can't be empty" : null,
                                fillColor: Colors.white,
                                hoverColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
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
                                labelText: "Email",
                                labelStyle: GoogleFonts.notoSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                fillColor: Colors.white,
                                hoverColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        portfolios == null
                            ? CircularProgressIndicator(
                                color: Colors.blue,
                              )
                            : Container(
                                padding: EdgeInsets.only(left: 50),
                                child: DropdownButton<String>(
                                  value: selectedPortfolio,
                                  icon: const Icon(Icons.arrow_drop_down_sharp),
                                  iconSize: 24,
                                  elevation: 16,
                                  isExpanded: true,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    width: 20,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedPortfolio = newValue!;
                                    });
                                  },
                                  items: portfolios!['portfolios']!
                                      .map<DropdownMenuItem<String>>(
                                          (portfolio) {
                                    return DropdownMenuItem<String>(
                                      value: portfolio['id'].toString(),
                                      child: Text(portfolio['name']),
                                    );
                                  }).toList(),
                                ),
                              ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(50, 5, 0, 0),
                                child: ElevatedButton(
                                  onPressed: () => uploadImage(),
                                  child: Text("Upload Image"),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
                                height: 45,
                                width: 35,
                                child: image == null
                                    ? Text(
                                        "No Image",
                                        style:
                                            GoogleFonts.notoSans(fontSize: 10),
                                      )
                                    : Expanded(
                                        child: Container(
                                            margin: EdgeInsets.fromLTRB(2, 5, 0, 0),
                                            height: 45,
                                            width: 35,
                                            child: Image.memory(image!.bytes!, width: 35, height: 45,)),
                                      ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 50),
                          child: TextField(
                            controller: firstNameController,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.black,
                            cursorHeight: 25,
                            cursorWidth: 3.2,
                            decoration: InputDecoration(
                                filled: true,
                                labelText: "First Name",
                                labelStyle: GoogleFonts.notoSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                // errorText:
                                // _validateEmail ? "email can't be empty" : null,
                                fillColor: Colors.white,
                                hoverColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 50),
                          child: TextField(
                            controller: contactNameController,
                            keyboardType: TextInputType.phone,
                            cursorColor: Colors.black,
                            cursorHeight: 25,
                            cursorWidth: 3.2,
                            decoration: InputDecoration(
                                filled: true,
                                labelText: "Contact",
                                labelStyle: GoogleFonts.notoSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                // errorText:
                                // _validateEmail ? "email can't be empty" : null,
                                fillColor: Colors.white,
                                hoverColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        faculties == null
                            ? CircularProgressIndicator(
                                color: Colors.blue,
                              )
                            : Container(
                                padding: EdgeInsets.only(left: 50),
                                child: DropdownButton<String>(
                                  value: selectedFaculty,
                                  icon: const Icon(Icons.arrow_drop_down_sharp),
                                  iconSize: 24,
                                  elevation: 16,
                                  isExpanded: true,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    width: 20,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedFaculty = newValue!;
                                    });
                                  },
                                  items: faculties!
                                      .map<DropdownMenuItem<String>>((faculty) {
                                    return DropdownMenuItem<String>(
                                      value: faculty['id'].toString(),
                                      child: Text(faculty['name']),
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
                            controller: lastNameController,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.black,
                            cursorHeight: 25,
                            cursorWidth: 3.2,
                            decoration: InputDecoration(
                                filled: true,
                                labelText: "Last Name",
                                labelStyle: GoogleFonts.notoSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                // errorText:
                                // _validateEmail ? "email can't be empty" : null,
                                fillColor: Colors.white,
                                hoverColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 50),
                          child: TextField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            cursorColor: Colors.black,
                            cursorHeight: 25,
                            cursorWidth: 3.2,
                            obscureText: true,
                            decoration: InputDecoration(
                                filled: true,
                                labelText: "Password",
                                labelStyle: GoogleFonts.notoSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                // errorText:
                                // _validateEmail ? "email can't be empty" : null,
                                fillColor: Colors.white,
                                hoverColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        departments == null
                            ? CircularProgressIndicator(
                                color: Colors.blue,
                              )
                            : Container(
                                padding: EdgeInsets.only(left: 50),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  items: departments!["departments"]
                                      .map<DropdownMenuItem<String>>(
                                          (department) {
                                    return DropdownMenuItem<String>(
                                      value: department['id'],
                                      child: Text(department['name']),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    selectedDepartment = value!;
                                  },
                                  value: selectedDepartment,
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 50),
                    child: ElevatedButton(
                      onPressed: () {
                        cancel();
                      },
                      child: Text(
                        "Cancel",
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
                      onPressed: () async {
                        int status = await submit();
                        if (status == 200) {
                          usersProvider.addUser(User(
                            email: emailController!.text,
                            lastName: lastNameController!.text,
                            firstName: firstNameController!.text,
                            portfolio: selectedPortfolio!,
                            id: userIDController!.text,

                          ));
                          Navigator.of(context).pop();
                        }
                        // clearAll();
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
          ],
        ),
      ),
    );
  }
}
