final String tableDocuments = 'documents';

class DocumentFields {
  static final List<String> values = [
    // Add documents fields
    id, size, name, type, dateModified
  ];

  static final String id = '_id';
  static final String size = 'size';
  static final String name = 'name';
  static final String type = 'type';
  static final String dateModified = 'dateModified';
}

class Document {
  final int? id;
  final String size;
  final String name;
  final String type;
  final DateTime dateModified;

  const Document({
    this.id,
    required this.size,
    required this.name,
    required this.type,
    required this.dateModified,
  });

  Document copy({
    int? id,
    String? size,
    String? name,
    String? type,
    DateTime? dateModified,
  }) =>
      Document(
        id: id ?? this.id,
        size: size ?? this.size,
        name: name ?? this.name,
        type: type ?? this.type,
        dateModified: dateModified ?? this.dateModified,
      );

  static Document fromJson(Map<String, Object?> json) => Document(
        id: json[DocumentFields.id] as int?,
        size: json[DocumentFields.size] as String,
        name: json[DocumentFields.name] as String,
        type: json[DocumentFields.type] as String,
        dateModified: DateTime.parse(json[DocumentFields.dateModified] as String),
      );

  Map<String, Object?> toJson() => {
        DocumentFields.id: id,
        DocumentFields.name: name,
        DocumentFields.size: size,
        DocumentFields.type: type,
        DocumentFields.dateModified: dateModified.toIso8601String(),
      };
}
