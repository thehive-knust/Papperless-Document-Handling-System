import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softdoc/cubit/android_nav_cubit/AndroidNav_cubit.dart';
import 'package:softdoc/models/doc.dart';
import 'package:softdoc/screens/auth_screen/auth_screen.dart';
import 'package:softdoc/screens/detail_screen/detail_screen.dart';
import 'package:softdoc/screens/home_screen/home_screen.dart';
import 'package:softdoc/screens/reveived_detail_screen/received_detail_screen.dart';
import 'package:softdoc/screens/send_doc_screen/send_doc_screen.dart';

class AndroidScreen extends StatefulWidget {
  const AndroidScreen({Key key}) : super(key: key);

  @override
  _AndroidScreenState createState() => _AndroidScreenState();
}

class _AndroidScreenState extends State<AndroidScreen> {
  // AndroidNavCubit _androidNavCubit;

  @override
  void initState() {
    super.initState();
    // _androidNavCubit = BlocProvider.of<AndroidNavCubit>(context);
    // _androidNavCubit.navToHomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AndroidNavCubit, AndroidNavState>(
        builder: (context, state) {
      if (state is HomeScreenNav)
        return HomeScreen();
      else if (state is DetailScreenNav)
        return DetailScreen(selectedDoc: state.selectedDoc);
      else if (state is ReveivedDetailScreenNav)
        return ReceivedDetailScreen(selectedDoc: state.selectedDoc);
      else if (state is SendDocScreenNav) return SendDocScreen();
      return CircularProgressIndicator();
    });
  }
}
