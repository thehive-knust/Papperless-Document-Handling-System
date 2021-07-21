// in this primary side, the users that are assigned to the departments are those who can approve only, because
// when the user is sending a file, he'll choose from there, so they should all be users who can approve

class User {
  String id;
  String name;
  String password;
  String email;
  String dept_id;
  String fac_id;
  String col_id;
  String port_id;
  String title;
  bool canApprove;

  User({
    this.id,
    this.name,
    this.password,
    this.email,
    this.dept_id,
    this.fac_id,
    this.col_id,
    this.port_id,
    this.title,
    this.canApprove,
  });
}
