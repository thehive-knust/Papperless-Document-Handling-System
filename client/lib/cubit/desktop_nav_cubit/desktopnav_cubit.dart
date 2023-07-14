import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:softdoc/models/doc.dart';

part 'desktopnav_state.dart';

class DesktopNavCubit extends Cubit<DesktopNavState> {
  DesktopNavCubit() : super(HomeScreenNav());

  void navToSendDocScreen() {
    emit(SendDocScreenNav());
  }

  void navToDetailScreen(Doc selectedDoc) {
    emit(DetailScreenNav(selectedDoc));
  }

  void navToHomeScreen() {
    emit(HomeScreenNav());
  }

  void navToreceivedDetailScreen(Doc selectedDoc) {
    emit(ReceivedDetailScreenNav(selectedDoc));
  }

  void navToPdfViewer({Doc? selectedDoc, bool? fromReceivedScreen}) {
    emit(PdfViewerNav(selectedDoc, fromReceivedScreen));
  }
}
