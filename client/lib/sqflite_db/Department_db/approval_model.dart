import 'approval_fields.dart';

class Department {
  final int id;
  final String name;



  const Department({
    this.id,
    this.name,

  });

  Department copy({
    int id,
    String name,
  }) =>
      Department(
        id: id ?? this.id,
        name: name ?? this.name,
      );


  /// converts map data values to object type data
  static Department fromMapTo(Map<String, Object> mapData) => Department(
        id: mapData[DepartmentFields.id] as int,
        name: mapData[DepartmentFields.name] as String,

      );

  /// converts object type values to map  data  type
  Map<String, Object> toMap() => {
        DepartmentFields.id: id,
        DepartmentFields.name: name,
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