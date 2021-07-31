import 'document_fields.dart';

class Document {
  final int id;
  final String subject;
  final String filepath;
  final String description;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userID;



  const Document({
    this.id,
    this.subject,
    this.filepath,
    this.description,
    this.updatedAt,
    this.status,
    this.createdAt,
    this.userID,
  });

  Document copy({
    int id,
    String subject,
    String filepath,
    String description,
    DateTime updatedAt,
    String status,
    DateTime createdAt,
    int userID
  }) =>
      Document(
        id: id ?? this.id,
        subject: subject ?? this.subject,
        filepath: filepath ?? this.filepath,
        description: description ?? this.description,
        updatedAt: updatedAt ?? this.updatedAt,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        userID: userID ?? this.userID,
      );


  /// converts map data values to object type data
  static Document fromMapTo(Map<String, Object> mapData) => Document(
        id: mapData[DocumentFields.id] as int,
        subject: mapData[DocumentFields.subject] as String,
        filepath: mapData[DocumentFields.filepath] as String,
        description: mapData[DocumentFields.description] as String,
        updatedAt:
        DateTime.parse(mapData[DocumentFields.updatedAt] as String),
        status: mapData[DocumentFields.status] as String,
        createdAt:
        DateTime.parse(mapData[DocumentFields.createdAt] as String),
        userID: mapData[DocumentFields.userID] as int,
      );

  /// converts object type values to map  data  type
  Map<String, Object> toMap() => {
        DocumentFields.id: id,
        DocumentFields.filepath: filepath,
        DocumentFields.subject: subject,
        DocumentFields.description: description,
        DocumentFields.updatedAt: updatedAt.toIso8601String(),
        DocumentFields.status: status,
        DocumentFields.createdAt: createdAt.toIso8601String(),
        DocumentFields.userID: userID,
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