import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softdoc/cubit/AndroidNav_cubit.dart';
import 'package:softdoc/platformSelect.dart';
import 'package:softdoc/screens/auth_screen/auth_screen.dart';
import 'package:softdoc/screens/desktop_screen/desktop_auth_screen.dart';
import 'package:softdoc/screens/detail_screen/detail_screen.dart';
import 'package:softdoc/screens/send_doc_screen/send_doc_screen.dart';
import 'style.dart';
// import 'package:softdoc/screens/home_screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AndroidNavCubit>(create: (context) => AndroidNavCubit())
        ],
        child: PlatformSelect(),
      ),
      // routes: {
      //   HOMEPAGE : (context) => PlatformSelect(),
      //   DETAILPAGE: (context) => DetailScreen(),
      //   SENDPAGE: (context) => SendDocScreen(),
      //   DESKTOPAUTHPAGE: (context) => DesktopAuthScreen(),
      //   AUTHPAGE: (context) => AuthScreen(),
      // },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
