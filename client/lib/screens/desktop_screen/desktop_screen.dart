import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softdoc/cubit/desktop_nav_cubit/desktopnav_cubit.dart';
import 'package:softdoc/screens/desktop_screen/desktop_auth_screen.dart';
import 'package:softdoc/screens/detail_screen/detail_screen.dart';
import 'package:softdoc/screens/home_screen/home_screen.dart';
import 'package:softdoc/screens/send_doc_screen/add_or_edit_recepient.dart';
import 'package:softdoc/screens/send_doc_screen/select_recepient.dart';
import 'package:softdoc/screens/send_doc_screen/send_doc_screen.dart';

class DesktopScreen extends StatefulWidget {
  const DesktopScreen({Key key}) : super(key: key);

  @override
  _DesktopScreenState createState() => _DesktopScreenState();
}

class _DesktopScreenState extends State<DesktopScreen> {
  void changeState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: [
          Container(
            height: double.infinity,
            width: screenSize.width * 0.33,
            child: HomeScreen(isDesktop: true),
          ),
          Expanded(
            child: BlocBuilder<DesktopNavCubit, DesktopNavState>(
              builder: (context, state) {
                // nav to send document screen:--------------------------------------
                if (state is SendDocScreenNav) {
                  return Row(
                    children: [
                      Expanded(child: SendDocScreen(isDesktop: true)),
                      Expanded(
                        child: Container(
                          // color: Colors.red,
                          padding:
                              EdgeInsets.only(top: 12, right: 10, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child:
                                      addOrEditReciepient(true, changeState)),
                              SizedBox(height: 10),
                              Expanded(child: selectRecepient(changeState))
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }
                // navigate to detail screen:-------------------------------------
                else if (state is DetailScreenNav) {
                  return Row(
                    children: [
                      Expanded(
                          child: DetailScreen(
                        isDesktop: true,
                        selectedDoc: state.selectedDoc,
                      )),
                      Expanded(
                        child: Center(
                          child:
                              Text('replace with vertical approval progress'),
                        ),
                      )
                    ],
                  );
                } else if (state is HomeScreenNav) {
                  return Center(child: Text("replace with app icon"));
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}
