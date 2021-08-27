

import 'package:admin_screen/state_model.dart';

class Repository {

  List<dynamic> getAll() => facultyDepartments;

  getLocalByState(String faculty) => facultyDepartments
      .map((map) => FacultyModel.fromJson(map))
      .where((item) => item.faculty == faculty)
      .map((item) => item.departments)
      .expand((i) => i!)
      .toList();

  List<String>? getFaculties() => facultyDepartments
      .map((map) => FacultyModel.fromJson(map))
      .map((item) => item.faculty!)
      .toList();


  List facultyDepartments = [
    {
      "faculty": "Faculty of Electrical and Computer",
      "departments": [
        "Department of Computer Engineering",
        "Department of Electrical and Electronics Engineering",
        "Department of Telecommunications Engineering"
      ]
    },
    {
      "faculty": "Faculty of Civil and Geo Engineering",
      "departments": [
        "Department of Civil Engineering",
        "Department of Petroleum Engineering",
        "Department of Geomatic Engineering",
        "Department of Geological Engineering",
      ]
    },
    {
      "faculty": "Faculty of Mechanical and Chemical Engineering",
      "departments": [
        "Department of Mechanical Engineering",
        "Department of Chemical Engineering",
        "Department of Materials Engineering",
        "Department of Agricultural and BioSystems Engineering"
      ]
    },
  ];
}
