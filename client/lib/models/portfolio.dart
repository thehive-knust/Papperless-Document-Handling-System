class Portfolio {
  String? id;
  String? title;
  bool? canApprove;

  Portfolio({this.id, this.title});

  static List<Portfolio> get portfolios => [
        Portfolio(id: "1", title: "Patron"),
        Portfolio(id: "2", title: "HOD"),
        Portfolio(id: "2", title: "HOD"),
        Portfolio(id: "3", title: "Registrar"),
        Portfolio(id: "4", title: "Student Affairs"),
      ];
}
