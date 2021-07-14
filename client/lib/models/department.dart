import 'package:softdoc/models/office.dart';

class Department {
  String id;
  String name;
  List<Office> offices;

  Department({this.id, this.name, this.offices});

  static List<Department> get departments => [
        Department(
          id: "1",
          name: "Department of Computer Engineering",
          offices: [
            Office(id: "1", portfolio: "HOD"),
            Office(id: "2", portfolio: "Registrar"),
            Office(id: "3", portfolio: "Patron"),
            Office(id: "4", portfolio: "Student Affairs")
          ],
        ),
        Department(
          id: "2",
          name: "Department of Biomedical Engineering",
          offices: [
            Office(id: "1", portfolio: "HOD"),
            Office(id: "2", portfolio: "Registrar"),
            Office(id: "3", portfolio: "Patron"),
            Office(id: "4", portfolio: "Student Affairs")
          ],
        ),
        Department(
          id: "3",
          name: "Department of Telecommunication Engineering",
          offices: [
            Office(id: "1", portfolio: "HOD"),
            Office(id: "2", portfolio: "Registrar"),
            Office(id: "3", portfolio: "Patron"),
            Office(id: "4", portfolio: "Student Affairs")
          ],
        ),
        Department(
          id: "4",
          name: "Department of Petrolium Engineering",
          offices: [
            Office(id: "1", portfolio: "HOD"),
            Office(id: "2", portfolio: "Registrar"),
            Office(id: "3", portfolio: "Patron"),
            Office(id: "4", portfolio: "Student Affairs")
          ],
        ),
        Department(
          id: "5",
          name: "Department of Mechanical Engineering",
          offices: [
            Office(id: "1", portfolio: "HOD"),
            Office(id: "2", portfolio: "Registrar"),
            Office(id: "3", portfolio: "Patron"),
            Office(id: "4", portfolio: "Student Affairs")
          ],
        ),
        Department(
          id: "6",
          name: "Department of Aerospace Engineering",
          offices: [
            Office(id: "1", portfolio: "HOD"),
            Office(id: "2", portfolio: "Registrar"),
            Office(id: "3", portfolio: "Patron"),
            Office(id: "4", portfolio: "Student Affairs")
          ],
        ),
      ];
}
