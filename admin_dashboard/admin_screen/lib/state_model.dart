class FacultyModel {
  String? faculty;


  List<String>? departments;

  FacultyModel({required this.faculty, required this.departments});

  FacultyModel.fromJson(Map<String, dynamic> json) {
    faculty = json['faculty'];
    departments = json['departments'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['faculty'] = this.faculty;
    data['departments'] = this.departments;
    return data;
  }
}
