// in this primary side, the users that are assigned to the departments are those who can approve only, because
// when the user is sending a file, he'll choose from there, so they should all be users who can approve

class User {
  String id;
  String name;
  String password;
  String email;
  String deptId;
  String facId;
  String colId;
  String portId;
  String title;
  bool canApprove;

  User({
    this.id,
    this.name,
    this.password,
    this.email,
    this.deptId,
    this.facId,
    this.colId,
    this.portId,
    this.title,
    this.canApprove,
  });

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
