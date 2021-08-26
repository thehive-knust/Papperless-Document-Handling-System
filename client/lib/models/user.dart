class User {
  String id;
  String name;
  String email;
  String deptId;
  String facId;
  String colId;
  String portId;
  String title;

  User({
    this.id,
    this.name,
    this.email,
    this.deptId,
    this.facId,
    this.colId,
    this.portId,
    this.title,
  });

  factory User.fromJson(json) {
    return User(
      id: json["id"].toString(),
      deptId: json['department_id'] ?? "",
      title: json['portfolio'],
      colId: json['college_id'].toString(),
      email: json['email'],
    );
  }
}
