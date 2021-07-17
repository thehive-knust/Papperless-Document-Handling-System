import 'dart:io';
import 'staff.dart';

class Doc {
  String status;
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
    this.status
  });

  static List<Map<String, List<Doc>>> get docs => [
        {
          "Today": [
            Doc(
              id: "1",
              subject: "Request for Classroom",
              approvalProgress: {"PATRON": true, "HDO": null, "SLDKFJSVBCXVBBXV": null, "SDLFSDKL DSFGDSFGSD": null},
              approved: null,
              timeCreated: DateTime.now(),
              status: "pending",
              description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
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
