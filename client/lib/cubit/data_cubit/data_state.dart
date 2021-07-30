part of 'data_cubit.dart';

@immutable
abstract class DataState {}

class DataInitial extends DataState {}

class SentDoc extends DataState {
  final List<Map<String, List<Doc>>> docs;
  SentDoc(this.docs);
}

class ReveivedDoc extends DataState {
  final List<Map<String, List<Doc>>> docs;
  ReveivedDoc(this.docs);
}


