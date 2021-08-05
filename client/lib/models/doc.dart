import 'dart:io';

class Doc {
  String id;
  String status;
  String subject;
  String description;
  File file;
  String fileUrl;
  String filename;
  String senderId;
  DateTime createdAt;
  DateTime updatedAt;
  Map<String, String> approvalProgress;
  Doc({
    this.id,
    this.subject,
    this.description,
    this.filename,
    this.file,
    this.senderId,
    this.createdAt,
    this.updatedAt,
    this.approvalProgress,
    this.status,
    this.fileUrl,
  });

  factory Doc.fromJson(Map<String, dynamic> json) {
    return Doc(
      id: json['id'],
      status: json['status'],
      subject: json['subject'] ?? null,
      description: json['description'] ?? null,
      senderId: json['senderId'],
      createdAt: json['createdAt'] ?? null,
      updatedAt: json['updatedAt'] ?? null,
      fileUrl: json['fileUrl'] ?? null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'status': this.status,
      'subject': this.subject,
      'description': this.description,
      'senderId': this.senderId,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'file': this.file
    };
  }

  static List<Map<String, List<Doc>>> reveivedDocs = [
    {
      "Today": [
        Doc(
          id: "1",
          subject: "CBET programm",
          approvalProgress: {
            "PATRON": 'approved',
            "HDO": 'pending',
            "Student Affairs": 'pending',
            "President": 'pending'
          },
          fileUrl: "http://africau.edu/images/default/sample.pdf",
          filename: "sample.pdf",
          createdAt: DateTime.now(),
          status: "cancelled",
          description:
              "Lorem ipsum dolor sit amet, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat 'pending'a pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        ),
        Doc(
            id: "2",
            subject: "Engineering Audithorium",
            approvalProgress: {
              "1": 'approved',
              "2": 'approved',
              "3": 'rejected',
              "4": 'pending'
            },
            status: 'rejected'),
        Doc(
            id: "3",
            subject: "Request for Bench",
            approvalProgress: {
              "1": 'approved',
              "2": 'approved',
              "3": 'approved',
              "4": 'approved'
            },
            status: 'approved'),
      ],
    },
  ];

  static List<Map<String, List<Doc>>> sentDocs = [
    {
      "Today": [
        Doc(
          id: "1",
          subject: "Request for Classroom",
          approvalProgress: {
            "PATRON": 'approved',
            "HDO": 'pending',
            "Student Affairs": 'pending',
            "President": 'pending'
          },
          fileUrl: "http://africau.edu/images/default/sample.pdf",
          filename: "sample.pdf",
          createdAt: DateTime.now(),
          status: "cancelled",
          description:
              "Lorem ipsum dolor sit amet, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat 'pending'a pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        ),
        Doc(
          id: "2",
          subject: "Request for Classroom",
          approvalProgress: {
            "1": 'approved',
            "2": 'approved',
            "3": 'rejected',
            "4": 'pending'
          },
          status: 'rejected',
          createdAt: DateTime.now(),
        ),
        Doc(
          id: "3",
          subject: "Request for Classroom",
          approvalProgress: {
            "1": 'approved',
            "2": 'approved',
            "3": 'approved',
            "4": 'approved'
          },
          status: 'approved',
          createdAt: DateTime.now(),
        ),
      ],
    },
    {
      "Yesturday": [
        Doc(
          id: "4",
          subject: "Request for Classroom",
          approvalProgress: {
            "1": 'pending',
          },
          status: 'pending',
          createdAt: DateTime.now(),
        ),
        Doc(
          id: "5",
          subject: "Request for Classroom",
          approvalProgress: {
            "1": 'pending',
            "2": 'pending',
            "3": 'pending',
            "4": 'pending'
          },
          status: 'pending',
          createdAt: DateTime.now(),
        ),
        Doc(
          id: "6",
          subject: "Request for Classroom",
          approvalProgress: {
            "1": 'pending',
            "2": 'pending',
            "3": 'pending',
            "4": 'pending'
          },
          status: 'pending',
          createdAt: DateTime.now(),
        ),
        Doc(
          id: "7",
          subject: "Request for Classroom",
          approvalProgress: {
            "1": 'pending',
            "2": 'pending',
            "3": 'pending',
            "4": 'pending'
          },
          status: 'pending',
          createdAt: DateTime.now(),
        ),
      ],
    },
    {
      "Last Week": [
        Doc(
          id: "8",
          subject: "Request for Classroom",
          approvalProgress: {
            "1": 'pending',
            "2": 'pending',
            "3": 'pending',
            "4": 'pending'
          },
          status: 'cancelled',
          createdAt: DateTime.now(),
        ),
        Doc(
          id: "9",
          subject: "Request for Classroom",
          approvalProgress: {
            "1": 'pending',
            "2": 'pending',
            "3": 'pending',
            "4": 'pending'
          },
          status: 'approved',
          createdAt: DateTime.now(),
        ),
        Doc(
          id: "10",
          subject: "Request for Classroom",
          approvalProgress: {
            "1": 'pending',
            "2": 'pending',
            "3": 'pending',
            "4": 'pending'
          },
          status: 'approved',
          createdAt: DateTime.now(),
        ),
        Doc(
          id: "11",
          subject: "Request for Classroom",
          approvalProgress: {
            "1": 'pending',
            "2": 'pending',
            "3": 'pending',
            "4": 'pending'
          },
          status: 'approved',
          createdAt: DateTime.now(),
        ),
      ]
    }
  ];
}
