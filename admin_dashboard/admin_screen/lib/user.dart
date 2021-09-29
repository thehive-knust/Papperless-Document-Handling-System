class User {
  String id;
  String firstName;
  String lastName;
  String email;
  String? deptId;
  String? facId;
  String colId = 'COE';
  String? portId;
  String portfolio;
  String? imgUrl;
  String? contact;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      this.deptId,
      this.facId,
      this.portId,
      required this.portfolio,
      this.imgUrl,
      this.contact});

  factory User.fromJson(json) {
    return User(
      id: json["id"].toString(),
      deptId: json['department_id'].toString(),
      portfolio: json['portfolio'],
      email: json['email'],
      facId: json['faculty_id'].toString(),
      firstName: json['first_name'],
      lastName: json['last_name'],
      imgUrl: json['img_url'],
      contact: json['contact'],
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'id: ${this.id} \n name:${this.firstName} \n email: ${this.email} contact: ${this.contact} portfolio: ${this.portfolio}';
  }
}
