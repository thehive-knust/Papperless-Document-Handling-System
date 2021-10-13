part of 'desktopnav_cubit.dart';

@immutable
abstract class DesktopNavState {}

class HomeScreenNav extends DesktopNavState {}

class DetailScreenNav extends DesktopNavState {
  final Doc selectedDoc;
  DetailScreenNav(this.selectedDoc);
}

class ReceivedDetailScreenNav extends DesktopNavState {
  final Doc selectedDoc;
  ReceivedDetailScreenNav(this.selectedDoc);
}

class SendDocScreenNav extends DesktopNavState {}

class PdfViewerNav extends DesktopNavState {
  final selectedDoc;
  final fromReceivedScreen;
  PdfViewerNav(this.selectedDoc, this.fromReceivedScreen);
}
