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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'contact': contact!,
      'portfolio': portfolio,
      'college_id': colId,
      'faculty_id': facId,
      'department_id': deptId,
      'img_url': imgUrl,
    };
  }

  void bulkEdit(newAttributes) {
    if (newAttributes["id"] != null) id = newAttributes['id'];
    if (newAttributes["first_name"] != null)
      firstName = newAttributes['first_name'];
    if (newAttributes["last_name"] != null)
      lastName = newAttributes['last_name'];
    if (newAttributes["email"] != null) email = newAttributes['email'];
    if (newAttributes["contact"] != null) contact = newAttributes['contact'];
    if (newAttributes["portfolio"] != null)
      portfolio = newAttributes['portfolio'];
    if (newAttributes["college_id"] != null)
      colId = newAttributes["college_id"];
    if (newAttributes["faculty_id"] != null)
      facId = newAttributes["faculty_id"];
    if (newAttributes["department_id"] != null)
      deptId = newAttributes["department_id"];
  }

  @override
  String toString() {
    // TODO: implement toString
    return ' id: ${this.id} \n name:${this.firstName} \n email: ${this.email} \n contact: ${this.contact} \n portfolio: ${this.portfolio} \n portId: ${this.portId} \n ';
  }
}
