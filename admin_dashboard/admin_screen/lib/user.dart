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
    required this.id,
    required this.name,
    required this.email,
    required this.deptId,
    required this.facId,
    required this.colId,
    required this.portId,
    required this.title,
  });

  factory User.fromJson(json) {
    return User(
      id: json["id"].toString(),
      deptId: json['department_id'].toString(),
      title: json['portfolio'],
      colId: json['college_id'].toString(),
      email: json['email'], facId: '', name: '', portId: '',
    );
  }
}
