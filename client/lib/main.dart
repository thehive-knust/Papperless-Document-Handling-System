import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:softdoc/cubit/android_nav_cubit/AndroidNav_cubit.dart';
import 'package:softdoc/cubit/data_cubit/data_cubit.dart';
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
          BlocProvider<DataCubit>(create: (context) => DataCubit())
        ],
        child: PlatformSelect(),
      ), 
      debugShowCheckedModeBanner: false,
      title: 'SoftDoc',
      builder: EasyLoading.init(),
    );
  }
}
