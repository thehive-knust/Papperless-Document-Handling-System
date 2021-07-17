import 'package:softdoc/models/user.dart';

class Department {
  String id;
  String name;
  List<User> users;
  String facultyId;

  Department({this.id, this.name, this.users});

  static List<Department> get departments => [
        Department(
          id: "1",
          name: "Department of Computer Engineering",
          users: [
            User(id: "1", title: "HOD"),
            User(id: "2", title: "Registrar"),
            User(id: "3", title: "Patron"),
            User(id: "4", title: "Student Affairs")
          ],
        ),
        Department(
          id: "2",
          name: "Department of Biomedical Engineering",
          users: [
            User(id: "1", title: "HOD"),
            User(id: "2", title: "Registrar"),
            User(id: "3", title: "Patron"),
            User(id: "4", title: "Student Affairs")
          ],
        ),
        Department(
          id: "3",
          name: "Department of Telecommunication Engineering",
          users: [
            User(id: "1", title: "HOD"),
            User(id: "2", title: "Registrar"),
            User(id: "3", title: "Patron"),
            User(id: "4", title: "Student Affairs")
          ],
        ),
        Department(
          id: "4",
          name: "Department of Petrolium Engineering",
          users: [
            User(id: "1", title: "HOD"),
            User(id: "2", title: "Registrar"),
            User(id: "3", title: "Patron"),
            User(id: "4", title: "Student Affairs")
          ],
        ),
        Department(
          id: "5",
          name: "Department of Mechanical Engineering",
          users: [
            User(id: "1", title: "HOD"),
            User(id: "2", title: "Registrar"),
            User(id: "3", title: "Patron"),
            User(id: "4", title: "Student Affairs")
          ],
        ),
        Department(
          id: "6",
          name: "Department of Aerospace Engineering",
          users: [
            User(id: "1", title: "HOD"),
            User(id: "2", title: "Registrar"),
            User(id: "3", title: "Patron"),
            User(id: "4", title: "Student Affairs")
          ],
        ),
      ];
}
