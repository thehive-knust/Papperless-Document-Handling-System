import 'dart:convert';
import 'package:admin_screen/repository.dart';
import 'package:file_picker/file_picker.dart';
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

  Map<String, dynamic>? departments;
  Repository repo = Repository();

  List<String> faculties = ["Choose your Faculty"];
  String selectedFaculty = "Choose your Faculty";
  String? selectedDepartment;

  @override
  void initState() {
    faculties = List.from(faculties)..addAll(repo.getFaculties()!);
    super.initState();
    fetchDepartments();
    fetchPortfolios();
  }


  String? selectedPortfolio;

  Map<String, dynamic>? portfolios;

  List<String> collegesForKNUST = [
    "Select your College",
    // "COS",
  ];

  TextEditingController? userIDController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? firstNameController = TextEditingController();
  TextEditingController? lastNameController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? contactNameController = TextEditingController();

  // var counterUsers = [];

  Future<void> fetchDepartments() async {
    const url = "https://soft-doc.herokuapp.com/departments/get/COE";
    final response = await http.get(Uri.parse(url));
    departments = jsonDecode(response.body);
    setState(() {
      selectedDepartment = departments!['departments'][0]['id'];
    });
  }

  Future<void> fetchPortfolios() async {
    const url = "https://soft-doc.herokuapp.com/portfolios";
    final response = await http.get(Uri.parse(url));
    portfolios = jsonDecode(response.body);
    print(portfolios);
    setState(() {
      selectedPortfolio = portfolios!['portfolios'][0]['id'].toString();
    });
    // return response.body as Map<String, dynamic>;
  }

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



  Uri url = Uri.parse("https://soft-doc.herokuapp.com/auth/signup");

  Future<void> submit() async {
    try {
      var request = http.MultipartRequest('POST',Uri.parse('https://soft-doc.herokuapp.com/auth/signup'));
      // request.fields.addAll({
      //   "id": userIDController!.text,
      //   "first_name": firstNameController!.text,
      //   "last_name": lastNameController!.text,
      //   "email": emailController!.text,
      //   "contact": contactNameController!.text,
      //   "password": passwordController!.text,
      //   "faculty_id": selectedFaculty,
      //   "department_id": selectedDepartment!,
      //   "portfolio_id": selectedPortfolio!,
      // });
    request.files.add(http.MultipartFile.fromBytes('file', image!.bytes!.toList(), filename: image!.name));
      var response = await request.send();
      print('==================');
      print(response.statusCode);
    } catch (e) {
      print("authentication Error Message => " + e.toString());
      return null;
    }
  }

  void clearAll() {
    userIDController!.clear();
    firstNameController!.clear();
    lastNameController!.clear();
    emailController!.clear();
    contactNameController!.clear();
    passwordController!.clear();
  }



  PlatformFile? image;

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

  Color primaryLight = Color(0xFFEFF7FF);

  @override
  Widget build(BuildContext context) {
    if(portfolios == null) fetchPortfolios();
    if(departments == null) fetchDepartments();
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
                        // Container(
                        //   padding: EdgeInsets.only(left: 50),
                        //   child: DropdownButton<String>(
                        //     value: collegeDropdown,
                        //     icon: const Icon(Icons.arrow_drop_down_sharp),
                        //     iconSize: 24,
                        //     elevation: 16,
                        //     isExpanded: true,
                        //     hint: Text("Select your College"),
                        //     style: const TextStyle(color: Colors.deepPurple),
                        //     underline: Container(
                        //       height: 2,
                        //       width: 20,
                        //       color: Colors.deepPurpleAccent,
                        //     ),
                        //     onChanged: (String? newValue) {
                        //       setState(() {
                        //         collegeDropdown = newValue!;
                        //       });
                        //     },
                        //     items: collegesForKNUST
                        //         .map<DropdownMenuItem<String>>((String value) {
                        //       return DropdownMenuItem<String>(
                        //         value: value,
                        //         child: Text(value),
                        //       );
                        //     }).toList(),
                        //   ),
                        // ),
                        portfolios == null? CircularProgressIndicator(color: Colors.blue,): Container(
                          padding: EdgeInsets.only(left: 50),
                          child: DropdownButton<String>(
                            value: selectedPortfolio,
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
                                selectedPortfolio = newValue!;
                              });
                            },
                            items: portfolios!['portfolios']!
                                .map<DropdownMenuItem<String>>((portfolio) {
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
                                    : Expanded(child: Image.memory(image!.bytes!),),
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
                        // Container(
                        //   padding: EdgeInsets.only(left: 50),
                        //   child: DropdownButton<String>(
                        //     isExpanded: true,
                        //     style: const TextStyle(color: Colors.deepPurple),
                        //     items: faculties.map((String dropDownStringItem) {
                        //       return DropdownMenuItem<String>(
                        //         value: dropDownStringItem,
                        //         child: Text(dropDownStringItem),
                        //       );
                        //     }).toList(),
                        //     onChanged: (value) => _onSelectedState(value!),
                        //     value: selectedFaculty,
                        //   ),
                        // ),
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
                        departments == null? CircularProgressIndicator(color: Colors.blue,):Container(
                          padding: EdgeInsets.only(left: 50),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            style: const TextStyle(color: Colors.deepPurple),
                            items: departments!["departments"]
                                .map<DropdownMenuItem<String>>((department) {
                              return DropdownMenuItem<String>(
                                value: department['id'],
                                child: Text(department['name']),
                              );
                            }).toList(),
                            // onChanged: (value) => print(value),
                            onChanged: (value) {
                              selectedDepartment = value!;
                              selectedFaculty = departments!["departments"]
                                  .singleWhere((department) =>
                                      department.id == value)['faculty_id'];
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
                        clearAll();
                      },
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
                        submit();
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
