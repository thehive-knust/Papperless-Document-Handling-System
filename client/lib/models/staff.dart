class Staff {
  String id;
  String portfolio;

  Staff({this.id, this.portfolio});

  static List<Staff> get staff => [
        Staff(id: "1", portfolio: "Patron"),
        Staff(id: "2", portfolio: "HOD"),
        Staff(id: "3", portfolio: "Registrar"),
        Staff(id: "4", portfolio: "Student Affairs")
  ];
}
