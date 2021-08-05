import 'package:softdoc/models/user.dart';

class Department {
  String id;
  String name;
  List<User> users;
  String facultyId;

  Department({this.id, this.name, this.users, this.facultyId});

  static List<User> get getUsers {
    List<User> users = [];
    departments.forEach((dept) => users.addAll(dept.users));
    return users;
  }

  factory Department.fromJson(json) {
    return Department(
      id: json['id'].toString(),
      name: json['name'],
      facultyId: json['faculty_id'].toString() ?? null,
    );
  }
  
  static List<Department> get departments => [
        Department(
          id: "25",
          name: "Department of Computer Engineering",
          users: [
            User(id: "1", title: "HOD"),
            User(id: "2", title: "Registrar"),
            User(id: "3", title: "Patron"),
            User(id: "4", title: "Student Affairs"),
            User(id: "31", title: "Facility manageer"),
            User(id: "32", title: "Financial manager"),
            User(id: "33", title: "General Secretary"),
            User(id: "34", title: "Aces President"),
          ],
        ),
        Department(
          id: "26",
          name: "Department of Biomedical Engineering",
          users: [
            User(id: "5", title: "Registrar"),
            User(id: "6", title: "HOD"),
            User(id: "24", title: "Patron"),
            User(id: "7", title: "Student Affairs")
          ],
        ),
        Department(
          id: "27",
          name: "Department of Telecommunication Engineering",
          users: [
            User(id: "8", title: "Patron"),
            User(id: "9", title: "Registrar"),
            User(id: "10", title: "HOD"),
            User(id: "11", title: "Student Affairs")
          ],
        ),
        Department(
          id: "28",
          name: "Department of Petrolium Engineering",
          users: [
            User(id: "12", title: "HOD"),
            User(id: "13", title: "Student Affairs"),
            User(id: "14", title: "Patron"),
            User(id: "15", title: "Registrar")
          ],
        ),
        Department(
          id: "29",
          name: "Department of Mechanical Engineering",
          users: [
            User(id: "16", title: "HOD"),
            User(id: "17", title: "Registrar"),
            User(id: "18", title: "Patron"),
            User(id: "19", title: "Student Affairs")
          ],
        ),
        Department(
          id: "30",
          name: "Department of Aerospace Engineering",
          users: [
            User(id: "20", title: "HOD"),
            User(id: "21", title: "Registrar"),
            User(id: "22", title: "Patron"),
            User(id: "23", title: "Student Affairs")
          ],
        ),
      ];

  static List<Map<String, dynamic>> dumyJson() {
    return [
      {
        "id": "111",
        "name": "Department of Computer Engineering",
        "facultyId": "101"
      },
      {
        "id": "222",
        "name": "Department of Petroleum Engineering",
        "facultyId": "202"
      },
      {
        "id": "333",
        "name": "Department of Mechanical Engineering",
        "facultyId": "303"
      },
      {
        "id": "444",
        "name": "Department of Marine Engineering",
        "facultyId": "404"
      },
    ];
  }
}
