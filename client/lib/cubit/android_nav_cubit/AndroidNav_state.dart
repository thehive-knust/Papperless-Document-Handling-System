part of 'AndroidNav_cubit.dart';

@immutable
abstract class AndroidNavState {}

class DetailScreenNav extends AndroidNavState {
  final Doc selectedDoc;
  DetailScreenNav(this.selectedDoc);
}

class PdfViewerNav extends AndroidNavState {
  final selectedDoc;
  final fromReceivedScreen;
  PdfViewerNav(this.selectedDoc, this.fromReceivedScreen);
}

class receivedDetailScreenNav extends AndroidNavState {
  final Doc selectedDoc;
  receivedDetailScreenNav(this.selectedDoc);
}

class SendDocScreenNav extends AndroidNavState {}

class HomeScreenNav extends AndroidNavState {}
