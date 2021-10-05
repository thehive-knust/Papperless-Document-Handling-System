import 'package:admin_screen/services/requests_to_backend.dart';
import 'package:admin_screen/widgets/AdminUser.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String? id;
  String? testPass;
  String? password;
  bool isLoading = false;
  String errorMessage = "";

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blueAccent,
        margin: EdgeInsets.symmetric(horizontal: 400, vertical: 20)));
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = true;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment:
            isDesktop ? MainAxisAlignment.center : MainAxisAlignment.start,
        crossAxisAlignment:
            isDesktop ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            "SoftDoc",
            style: TextStyle(
              fontSize: 37,
              fontWeight: FontWeight.w600,
            ),
          ),
          isDesktop ? SizedBox(height: 10) : const SizedBox(height: 40),
          TextFormField(
            onChanged: (newId) => id = newId,
            validator: (newId) =>
                newId!.isEmpty ? "please enter ID number" : null,
            keyboardType: TextInputType.number,
            //decoration: authInputDecoration("Enter your ID number"),
          ),
          SizedBox(height: 15),
          TextFormField(
            onChanged: (pass) => password = pass,
            validator: (pass) => pass!.isEmpty ? "Please enter password" : null,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            //decoration: authInputDecoration('Password'),
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
                FocusScope.of(context).unfocus();
                if (_formKey.currentState!.validate()) {
                  isLoading = true;
                  setState(() {});
                  bool error = await Api.login(id, password);
                  if (error) {
                    errorMessage = "invalid User";
                    setState(() {});
                  }

                  isLoading = false;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminUser()));
                }
              },
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Verify", style: TextStyle(fontSize: 20)),
            ),
          ),
          SizedBox(height: 20),
          Text(errorMessage, style: TextStyle(color: Colors.red))
        ],
      ),
    );
  }
}
