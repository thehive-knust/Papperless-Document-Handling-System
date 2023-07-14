import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softdoc/cubit/data_cubit/data_cubit.dart';
import 'package:softdoc/style.dart';

class AuthForm extends StatefulWidget {
  final bool? isDesktop;
  AuthForm({Key? key, this.isDesktop}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  String? id;
  String? testPass;
  String? password;
  bool? isLoading = false;
  DataCubit? _dataCubit;
  String? errorMessage = "";

  @override
  void initState() {
    // -TODO: implement initState
    super.initState();
    _dataCubit = BlocProvider.of<DataCubit>(context);
    // _dataCubit.emit(Authenticated());
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        backgroundColor: primary,
        margin: EdgeInsets.symmetric(horizontal: 400, vertical: 20)));
  }

  void submit() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      bool error = await _dataCubit!.authenticate(id!, password!);
      if (error) {
        errorMessage = "wrong username or password";
        setState(() {});
      }

      isLoading = false;
      setState(() {});
    }
  }

  void togglePasswordVisibility() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: widget.isDesktop!
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        crossAxisAlignment: widget.isDesktop!
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
          widget.isDesktop! ? SizedBox(height: 10) : const SizedBox(height: 40),
          TextFormField(
            autofocus: true,
            onChanged: (newId) => id = newId,
            validator: (newId) =>
                newId!.isEmpty ? "please enter ID number" : null,
            keyboardType: TextInputType.number,
            decoration: authInputDecoration("Enter your ID number"),
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 15),
          TextFormField(
            onChanged: (pass) => password = pass,
            validator: (pass) => pass!.isEmpty ? "Please enter password" : null,
            obscureText: !passwordVisible,
            keyboardType: TextInputType.visiblePassword,
            decoration: authInputDecoration(
              'Password',
              passwordVisible: passwordVisible,
              togglePasswordVisibilty: togglePasswordVisibility,
            ),
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => submit(),
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
              onPressed: submit,
              child: isLoading!
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Verify", style: TextStyle(fontSize: 20)),
            ),
          ),
          SizedBox(height: 20),
          Text(errorMessage!, style: TextStyle(color: Colors.red))
        ],
      ),
    );
  }
}
