final String tableDocuments = 'documents';

class DocumentFields {
  static final List<String> values = [
    // Add documents fields
    id, subject, filepath, description, status, createdAt,  updatedAt, userID
  ];

  static final String id = '_id';
  //static final String user_id = 'user_id';
  static final String subject = 'subject';
  static final String filepath = 'filepath';
  static final String description = 'description';
  static final String status = 'status';
  static final String createdAt = 'createdAt';
  static final String updatedAt = 'updatedAt';
  static final String userID = 'userID';
}