import 'approval_fields.dart';

class Approval {
  final int id;
  final String status;
  final int docID;
  final int userID;



  const Approval({
    this.id,
    this.status,
    this.docID,
    this.userID,

  });

  Approval copy({
    int id,
    String status,
  }) =>
      Approval(
        id: id ?? this.id,
        status: status ?? this.status,
        docID: docID ?? this.docID,
        userID: userID ?? this.userID,
      );


  /// converts map data values to object type data
  static Approval fromMapTo(Map<String, Object> mapData) => Approval(
        id: mapData[ApprovalFields.id] as int,
        status: mapData[ApprovalFields.status] as String,
        docID: mapData[ApprovalFields.docID] as int,
        userID: mapData[ApprovalFields.userID] as int,

      );

  /// converts object type values to map  data  type
  Map<String, Object> toMap() => {
        ApprovalFields.id: id,
        ApprovalFields.status: status,
        ApprovalFields.docID: docID,
        ApprovalFields.userID: userID,
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