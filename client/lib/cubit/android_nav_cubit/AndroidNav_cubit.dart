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

  void navToReveivedDetailScreen(Doc selectedDoc) {
    emit(ReveivedDetailScreenNav(selectedDoc));
  }
  
}
