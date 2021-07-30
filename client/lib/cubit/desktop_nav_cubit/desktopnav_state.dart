part of 'desktopnav_cubit.dart';

@immutable
abstract class DesktopNavState {}

class HomeScreenNav extends DesktopNavState {}

class DetailScreenNav extends DesktopNavState {
  final Doc selectedDoc;
  DetailScreenNav(this.selectedDoc);
}

class ReveivedDetailScreenNav extends DesktopNavState {
  final Doc selectedDoc;
  ReveivedDetailScreenNav(this.selectedDoc);
}

class SendDocScreenNav extends DesktopNavState {}
