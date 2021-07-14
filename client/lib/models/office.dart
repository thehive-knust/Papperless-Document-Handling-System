class Office {
  String id;
  String portfolio;

  Office({this.id, this.portfolio});

  static List<Office> get office => [
        Office(id: "1", portfolio: "Patron"),
        Office(id: "2", portfolio: "HOD"),
        Office(id: "3", portfolio: "Registrar"),
        Office(id: "4", portfolio: "Student Affairs")
  ];
}
