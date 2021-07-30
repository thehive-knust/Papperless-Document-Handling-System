import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softdoc/cubit/android_nav_cubit/AndroidNav_cubit.dart';
import 'package:softdoc/cubit/auth_cubit/auth_cubit.dart';
import 'package:softdoc/cubit/data_cubit/data_cubit.dart';
import 'package:softdoc/cubit/desktop_nav_cubit/desktopnav_cubit.dart';
import 'package:softdoc/style.dart';
import 'package:crypto/crypto.dart';
import '../../services/flask_database.dart';

class AuthForm extends StatefulWidget {
  final bool isDesktop;
  AuthForm({Key key, this.isDesktop}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String id;
  String testPass;
  Digest password;
  bool isLoading = false;

  AndroidNavCubit _androidNavCubit;
  DesktopNavCubit _desktopNavCubit;
  AuthCubit _authCubit;
  DataCubit _dataCubit;

  @override
  void initState() {
    // -TODO: implement initState
    super.initState();
    _androidNavCubit = BlocProvider.of<AndroidNavCubit>(context);
    _desktopNavCubit = BlocProvider.of<DesktopNavCubit>(context);
    _dataCubit = BlocProvider.of<DataCubit>(context);
    _dataCubit.authenticate();
    // _authCubit = BlocProvider.of<AuthCubit>(context);
    // _authCubit.verify();
  }

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: widget.isDesktop
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        crossAxisAlignment: widget.isDesktop
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Text(
            "SoftDoc",
            style: TextStyle(
              fontSize: 37,
              fontWeight: FontWeight.w600,
            ),
          ),
          widget.isDesktop ? SizedBox(height: 10) : const SizedBox(height: 40),
          TextFormField(
            onChanged: (newId) {
              id = newId;
            },
            validator: (newId) =>
                newId.isEmpty ? "please enter ID number" : null,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              fillColor: primaryLight,
              hintText: "Enter your ID number",
              hoverColor: primary.withOpacity(.15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 15),
          TextFormField(
            onChanged: (pass) {
              // List<int> bytes = utf8.encode(pass);
              // password = sha512.convert(bytes);
              testPass = pass;
            },
            validator: (pass) => pass.isEmpty ? "Please enter password" : null,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              filled: true,
              fillColor: primaryLight,
              hintText: "password",
              hoverColor: primary.withOpacity(.15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            height: 45,
            width: double.infinity * 0.2,
            // margin: EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  isLoading = true;
                  setState(() {});
                  bool verified = await FlaskDatabase.authenticate(
                      userId: id, password: testPass);
                  // await FlaskDatabase.getLocal();
                  // FlaskDatabase.getMessage();
                  verified
                      ? _dataCubit.authenticate()
                      : ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("invalid user"),
                          ),
                        );

                  isLoading = false;
                  setState(() {});
                }
              },
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Verify", style: TextStyle(fontSize: 20)),
            ),
          )
        ],
      ),
    );
  }
}
