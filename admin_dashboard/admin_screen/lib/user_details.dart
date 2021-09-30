import 'package:admin_screen/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'user.dart';

class UserDetails extends StatefulWidget {
  final user;
  const UserDetails({Key? key, this.user}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  bool minimize = true;
  bool edited = false;
  TextEditingController? idController = TextEditingController(),
      firstNameController = TextEditingController(),
      lastNameController = TextEditingController(),
      emailController = TextEditingController(),
      portfolioController = TextEditingController(),
      collegeController = TextEditingController(),
      departmentController = TextEditingController(),
      facultyController = TextEditingController(),
      contactController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    minimize = usersProvider.selectedUser == null;
    double _width = minimize ? 0 : MediaQuery.of(context).size.width * 0.3;
    double _minWidth = minimize ? 0 : 300;
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      curve: Curves.decelerate,
      width: _width,
      constraints: BoxConstraints(maxWidth: 400, minWidth: _minWidth),
      height: double.infinity,
      color: Color(0xFFEFFDFF),
      child: minimize
          ? Container()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      splashRadius: 10,
                      onPressed: () {
                        usersProvider.showUserDetails(null);
                      },
                    ),
                  ),
                  Container(
                    child: CircleAvatar(
                      minRadius: 50,
                      maxRadius: 90,
                      backgroundImage: NetworkImage(usersProvider
                              .selectedUser?.imgUrl ??
                          'https://th.bing.com/th/id/OIP.wZuW_HMkyAy6VZsuu33jBgAAAA?pid=ImgDet&rs=1'),
                    ),
                  ),
                  UserAttribute(
                    label: 'user ID',
                    controller: idController!,
                  ),
                  UserAttribute(
                    label: 'first name',
                    controller: firstNameController!,
                  ),
                  UserAttribute(
                    label: 'last name',
                    controller: lastNameController!,
                  ),
                  UserAttribute(
                    label: 'email',
                    controller: emailController!,
                  ),
                  UserAttribute(
                    label: 'portfolio',
                    controller: portfolioController!,
                  ),
                  UserAttribute(
                    label: 'contact',
                    controller: contactController!,
                  ),
                  Selector<UsersProvider, bool>(
                    selector: (context, provider) => provider.userEdited,
                    builder: (context, userEdited, child) => userEdited
                        ? button('Save Changes', () {
                            usersProvider.updateUserDetails({
                              "id": idController!.text,
                              "first_name": firstNameController!.text,
                              "last_name": lastNameController!.text,
                              "email": emailController!.text,
                              "contact": contactController!.text
                            });
                          })
                        : Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: button('Delete user', () async {
                      bool succeeded = await usersProvider
                          .deleteUserFromDb(usersProvider.selectedUser!.id);
                      if (succeeded)
                        usersProvider
                            .removeUser(usersProvider.selectedUser!.id);
                    }),
                  ),
                ],
              ),
            ),
    );
  }
}

class UserAttribute extends StatefulWidget {
  final label;
  final controller;
  UserAttribute({Key? key, this.label, this.controller}) : super(key: key);
  @override
  _UserAttributeState createState() => _UserAttributeState();
}

class _UserAttributeState extends State<UserAttribute> {
  bool editable = false;

  String? value(User selectedUser) {
    switch (widget.label) {
      case 'user ID':
        return selectedUser.id;
      case 'first name':
        return selectedUser.firstName;
      case 'last name':
        return selectedUser.lastName;
      case 'email':
        return selectedUser.email;
      case 'contact':
        return selectedUser.contact;
      case 'portfolio':
        return selectedUser.portfolio;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: ListTile(
        title: Selector<UsersProvider, User>(
          selector: (context, provider) => provider.selectedUser!,
          builder: (context, selectedUser, child) {
            widget.controller.text = value(selectedUser) ?? 'not set';
            return TextField(
              controller: widget.controller,
              enabled: editable,
              readOnly: !editable,
              decoration: InputDecoration(
                labelText: widget.label,
                labelStyle: TextStyle(color: Colors.blueAccent, fontSize: 14),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: editable ? UnderlineInputBorder() : InputBorder.none,
                //enabled: true,
              ),
            );
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            setState(() {
              editable = true;
              UsersProvider usersProvider =
                  Provider.of<UsersProvider>(context, listen: false);
              if (!usersProvider.userEdited)
                usersProvider.updateUserEdited(true);
            });
          },
        ),
      ),
    );
  }
}

Widget button(String _text, Function() _onpressed) {
  return Container(
    padding: EdgeInsets.only(top: 10, right: 10),
    alignment: Alignment.centerRight,
    child: ElevatedButton(
      child: Text(_text),
      style: ButtonStyle(
          //foregroundColor: MaterialStateProperty.all(Colors.black),
          backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
          elevation: MaterialStateProperty.all(0)),
      onPressed: _onpressed,
    ),
  );
}
