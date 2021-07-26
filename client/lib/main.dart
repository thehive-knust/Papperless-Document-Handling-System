import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softdoc/cubit/android_nav_cubit/AndroidNav_cubit.dart';
import 'package:softdoc/cubit/auth_cubit/auth_cubit.dart';
import 'package:softdoc/platformSelect.dart';
import 'cubit/desktop_nav_cubit/desktopnav_cubit.dart';

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
          BlocProvider<AndroidNavCubit>(create: (context) => AndroidNavCubit()),
          BlocProvider<DesktopNavCubit>(create: (context) => DesktopNavCubit()),
          BlocProvider<AuthCubit>(create: (context) => AuthCubit())
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
      title: 'SoftDoc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
