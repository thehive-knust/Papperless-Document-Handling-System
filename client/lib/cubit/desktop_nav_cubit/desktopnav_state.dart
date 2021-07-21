part of 'desktopnav_cubit.dart';

@immutable
abstract class DesktopNavState {}

class DesktopNavInitial extends DesktopNavState {}

class DetailScreenNav extends DesktopNavState {
  final Doc selectedDoc;
  DetailScreenNav(this.selectedDoc);
}

class SendDocScreenNav extends DesktopNavState{}
