import 'dart:io';
import 'office.dart';

class Doc {
  String id;
  String subject;
  String description;
  File file;
  String senderId;
  bool approved;
  DateTime timeCreated;
  DateTime timeUpdated;
  Map<String, bool> approvalProgress;
  Doc({
    this.id,
    this.subject,
    this.description,
    this.file,
    this.senderId,
    this.approved,
    this.timeCreated,
    this.timeUpdated,
    this.approvalProgress,
  });

  static List<Map<String, List<Doc>>> get docs => [
        {
          "Today": [
            Doc(
              id: "1",
              subject: "Request for Classroom",
              approvalProgress: {"1": true, "2": null, "3": null, "4": null},
              approved: null,
            ),
            Doc(
              id: "2",
              subject: "Request for Classroom",
              approvalProgress: {"1": true, "2": true, "3": false, "4": null},
              approved: false
            ),
            Doc(
              id: "3",
                subject: "Request for Classroom",
                approvalProgress: {"1": true, "2": true, "3": true, "4": true},
                approved: true),
          ],
        },
        {
          "Yesturday": [
            Doc(
              id: "",
                subject: "Request for Classroom",
                approvalProgress: {"1": null, "2": null, "3": null, "4": null},
                approved: false),
            Doc(
              id: "",
              subject: "Request for Classroom",
              approvalProgress: {"1": null, "2": null, "3": null, "4": null},
            ),
            Doc(
              id: "",
              subject: "Request for Classroom",
              approvalProgress: {"1": null, "2": null, "3": null, "4": null},
            ),
            Doc(
              id: "",
                subject: "Request for Classroom",
                approvalProgress: {"1": null, "2": null, "3": null, "4": null},
                approved: true),
          ],
        },
        {
          "Last Week": [
            Doc(
              id: "",
                subject: "Request for Classroom",
                approvalProgress: {"1": null, "2": null, "3": null, "4": null},
                approved: true),
            Doc(
              id: "",
                subject: "Request for Classroom",
                approvalProgress: {"1": null, "2": null, "3": null, "4": null},
                approved: true),
            Doc(
              id: "",
                subject: "Request for Classroom",
                approvalProgress: {"1": null, "2": null, "3": null, "4": null},
                approved: false),
            Doc(
              id: "",
                subject: "Request for Classroom",
                approvalProgress: {"1": null, "2": null, "3": null, "4": null},
                approved: true),
          ]
        }
      ];
}
