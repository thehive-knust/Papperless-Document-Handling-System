import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:softdoc/models/doc.dart';
import 'package:softdoc/screens/home_screen/home_screen.dart';

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

  void navToReveivedDetailScreen(Doc selectedDoc) {
    emit(ReveivedDetailScreenNav(selectedDoc));
  }
}
