import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:softdoc/models/doc.dart';

part 'AndroidNav_state.dart';

class AndroidNavCubit extends Cubit<AndroidNavState> {
  AndroidNavCubit() : super(HomeScreenNav());

  void navToHomeScreen() {
    emit(HomeScreenNav());
  }

  void navToSendDocScreen() {
    emit(SendDocScreenNav());
  }

  void navToDetailScreen(Doc selectedDoc) {
    emit(DetailScreenNav(selectedDoc));
  }

  void navToreceivedDetailScreen(Doc selectedDoc) {
    emit(receivedDetailScreenNav(selectedDoc));
  }

  void navToPdfViewer({Doc? selectedDoc, bool? fromReceivedScreen}) {
    emit(PdfViewerNav(selectedDoc, fromReceivedScreen));
  }
}
