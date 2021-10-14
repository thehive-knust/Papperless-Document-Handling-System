import 'package:admin_screen/services/requests_to_backend.dart';
import 'package:admin_screen/widgets/AdminUser.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final isDesktop;
  AuthForm(this.isDesktop);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  String? id;
  String? testPass;
  String? password;
  bool isLoading = false;
  String errorMessage = "";
  Color primary = Color(0xFF61B1F8);
  Color primaryLight = Color(0xFFEFF7FF);

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blueAccent,
        margin: EdgeInsets.symmetric(horizontal: 400, vertical: 20)));
  }

  void togglePasswordVisibility() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  void submit() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      bool error = await Api.login(id, password);
      if (error) {
        errorMessage = "wrong username or password";
        setState(() {
          isLoading = false;
        });
        return;
      }

      isLoading = false;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminUser(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "SoftDoc",
                style: TextStyle(
                  fontSize: 37,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  "admin",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: primary,
                  ),
                ),
              ),
            ],
          ),
          widget.isDesktop ? SizedBox(height: 10) : const SizedBox(height: 40),
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
              isPasswordField: true,
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

  InputDecoration authInputDecoration(String hint,
      {bool isPasswordField = false}) {
    return InputDecoration(
      filled: true,
      fillColor: primaryLight,
      hintText: hint,
      hoverColor: primary.withOpacity(.15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(color: primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(color: Colors.red),
      ),
      suffixIcon: isPasswordField
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: togglePasswordVisibility,
                icon: Icon(
                  passwordVisible ? Icons.visibility_off : Icons.visibility,
                ),
                color: primary,
              ),
            )
          : null,
    );
  }
}
