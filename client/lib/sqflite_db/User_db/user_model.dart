import 'user_fields.dart';

class User {
  final int id;
  final String name;
  final int deptID;


  const User({
    this.id,
    this.name,
    this.deptID,
  });

  User copy({
    int id,
    String name,
    int deptID
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        deptID: deptID ?? this.deptID,
      );


  /// converts map data values to object type data
  static User fromMapTo(Map<String, Object> mapData) => User(
        id: mapData[UserFields.id] as int,
        name: mapData[UserFields.name] as String,
        deptID: mapData[UserFields.deptID] as int,

      );

  /// converts object type values to map  data  type
  Map<String, Object> toMap() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.deptID: deptID,
      };
}



























// final String tableDocuments = 'documents';
//
// class DocumentFields {
//   static final List<String> values = [
//     // Add documents fields
//     id, size, name, type, dateModified
//   ];
//
//   static final String id = '_id';
//   static final String size = 'size';
//   static final String name = 'name';
//   static final String type = 'type';
//   static final String dateModified = 'dateModified';
// }