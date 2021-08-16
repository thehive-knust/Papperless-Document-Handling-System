import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;

import 'dart:typed_data';

class Doc {
  String id;
  String status;
  String subject;
  String description;
  File file;
  Uint8List fileBytes;
  String fileUrl;
  String filename;
  String senderId;
  DateTime createdAt;
  DateTime updatedAt;
  Map<String, String> approvalProgress;
  Map<String, String> senderInfo;
  Doc({
    this.id,
    this.subject,
    this.description,
    this.filename,
    this.file,
    this.fileBytes,
    this.senderId,
    this.senderInfo,
    this.createdAt,
    this.updatedAt,
    this.approvalProgress,
    this.status,
    this.fileUrl,
  });

  factory Doc.fromJson(Map<String, dynamic> json, [isSent = true]) {
    return Doc(
      id: json['id'].toString(),
      status: json['progress'],
      subject: json['subject'] ?? null,
      description: json['description'] ?? null,
      senderId: json['user_id'].toString(),
      createdAt: DateTime.parse(json['created_at']) ?? DateTime.now(),
      updatedAt: DateTime.parse(json['updated_at']) ?? DateTime.now(),
      fileUrl: json['file'] ?? null,
      filename: json['name'] ?? null,
      approvalProgress: isSent ?Map<String, String>.from(json['approval_list']) :null,
      senderInfo: isSent? null: Map<String,String>.from(json['user_info'])
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subject': this.subject ?? "",
      'description': this.description ?? "",
      'user_id': this.senderId,
      'recipients': jsonEncode(this.approvalProgress)
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
          updatedAt: DateTime.now(),
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
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
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
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
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
