import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softdoc/cubit/android_nav_cubit/AndroidNav_cubit.dart';
import 'package:softdoc/cubit/auth_cubit/auth_cubit.dart';
import 'package:softdoc/screens/android_screen/android_screen.dart';
import 'package:softdoc/screens/auth_screen/auth_screen.dart';
import 'package:softdoc/screens/desktop_screen/desktop_auth_screen.dart';
import 'package:softdoc/screens/desktop_screen/desktop_screen.dart';

// import 'package:softdoc/screens/home_screen/home_screen.dart';
class PlatformSelect extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // bool isLoggedIn = false;
    bool isDesktop = MediaQuery.of(context).size.width > 500;

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthStateInitial) {
          return isDesktop ? DesktopAuthScreen() : AuthScreen();
        } else if (state is Verified) {
          return isDesktop ? DesktopScreen() : AndroidScreen();
        }

        return LinearProgressIndicator();
      },
    );
  }
}
