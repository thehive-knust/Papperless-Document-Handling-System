part of 'data_cubit.dart';

@immutable
abstract class DataState {}

class DataInitial extends DataState {}

class Authenticated extends DataState{}

class SentDoc extends DataState {
  final List<Map<String, List<Doc>>> docs;
  SentDoc(this.docs);
}

class ReceivedDoc extends DataState {
  final List<Map<String, List<Doc>>> docs;
  ReceivedDoc(this.docs);
}

//-----------------SIDE METHODS---------------------------------

  List<Map<String, List<Doc>>> getSections(List<Doc> docs) {
    List<Map<String, List<Doc>>> docSections = [];
    List<List> sections = [
      ["Today"],
      ["Yesterday"],
      ["Last week"],
      ["Earlier"]
    ];
    final now = DateTime.now();
    final todayDate = DateTime(now.year, now.month, now.day);
    final yesterdayDate = DateTime(now.year, now.month, now.day - 1);
    final lastWeekDate = DateTime(now.year, now.month, now.day - 7);
    docs.forEach((doc) {
      final date =
          DateTime(doc.updatedAt.year, doc.updatedAt.month, doc.updatedAt.day);
      if (date == todayDate) {
        sections[0].add(doc);
      } else if (date == yesterdayDate) {
        sections[1].add(doc);
      } else if (date.isBefore(lastWeekDate)) {
        sections[2].add(doc);
      } else {
        sections[3].add(doc);
      }
    });
    sections.forEach((section) {
      if (section.length > 1) {
        docSections.add({section[0]: List<Doc>.from(section.skip(1))});
      }
    });
    return docSections;
  }


