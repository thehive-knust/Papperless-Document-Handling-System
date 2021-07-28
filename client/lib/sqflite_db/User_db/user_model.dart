import 'user_fields.dart';

class User {
  final int id;
  final String name;



  const User({
    required this.id,
    required this.name,

  });

  User copy({
    int? id,
    String? name,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
      );


  /// converts map data values to object type data
  static User fromMapTo(Map<String, Object?> mapData) => User(
        id: mapData[UserFields.id] as int,
        name: mapData[UserFields.name] as String,

      );

  /// converts object type values to map  data  type
  Map<String, Object?> toMap() => {
        UserFields.id: id,
        UserFields.name: name,
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