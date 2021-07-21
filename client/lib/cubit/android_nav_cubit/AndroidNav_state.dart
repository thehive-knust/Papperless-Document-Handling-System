part of 'AndroidNav_cubit.dart';

@immutable
abstract class AndroidNavState {}

class AndroidNavInitial extends AndroidNavState {}

class DetailScreenNav extends AndroidNavState {
  final Doc selectedDoc;
  DetailScreenNav(this.selectedDoc);
}

class SendDocScreenNav extends AndroidNavState {}

class HomeScreenNav extends AndroidNavState {}
