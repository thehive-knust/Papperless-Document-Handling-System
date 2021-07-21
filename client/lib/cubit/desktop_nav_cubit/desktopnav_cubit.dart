import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:softdoc/models/doc.dart';

part 'desktopnav_state.dart';

class DesktopNavCubit extends Cubit<DesktopNavState> {
  DesktopNavCubit() : super(DesktopNavInitial());

  void navToSendDocScreen() {
    emit(SendDocScreenNav());
  }

  void navToDetailScreen(Doc selectedDoc) {
    emit(DetailScreenNav(selectedDoc));
  }
}
