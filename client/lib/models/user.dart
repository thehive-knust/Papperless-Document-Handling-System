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
      id: json["id"],
      deptId: json['deptId'],
      title: json['title'],
      colId: json['colId'],
    );
  }

  static List<Map<String, dynamic>> dumyJson() {
    return [
      {
        "id": "1",
        "name": "His/Her name",
        "email": "something@gmail.com",
        "dept_id": "111",
        "position": "HOD",
      },
      {},
      {},
      {},
    ];
  }
}
