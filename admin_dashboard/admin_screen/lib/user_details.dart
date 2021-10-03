import 'package:admin_screen/portfolio_provider.dart';
import 'package:admin_screen/users_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
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
                  DropdownUserAttribute(category: "portfolio"),
                  DropdownUserAttribute(category: "faculty"),
                  DropdownUserAttribute(category: "department"),
                  UserAttribute(
                    label: 'contact',
                    controller: contactController!,
                  ),
                  Selector<UsersProvider, bool>(
                    selector: (context, provider) => provider.userEdited,
                    builder: (context, userEdited, child) => userEdited
                        ? button('Save Changes', () {
                            final portfolioProvider =
                                Provider.of<PortfolioProvider>(context,
                                    listen: false);

                            usersProvider.updateUserDetails({
                              "id": idController!.text,
                              "first_name": firstNameController!.text,
                              "last_name": lastNameController!.text,
                              "email": emailController!.text,
                              "contact": contactController!.text,
                              "portfolio": portfolioProvider
                                  .portfolios!['selectedPortfolio'],
                              "faculty_id": portfolioProvider
                                  .faculties!['selectedFaculty'],
                              "department_id": portfolioProvider
                                  .departments!['selectedDepartment'],
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
            if (widget.controller != null)
              widget.controller.text = value(selectedUser) ?? 'not set';
            return attributeTextField(
                widget.label, editable, widget.controller);
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

Widget attributeTextField(label, editable, controller) {
  return TextField(
    controller: controller,
    enabled: editable,
    readOnly: !editable,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.blueAccent, fontSize: 14),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: editable ? UnderlineInputBorder() : InputBorder.none,
      //enabled: true,
    ),
  );
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

class DropdownUserAttribute extends StatefulWidget {
  final String category;
  const DropdownUserAttribute({Key? key, required this.category})
      : super(key: key);

  @override
  _DropdownUserAttributeState createState() => _DropdownUserAttributeState();
}

class _DropdownUserAttributeState extends State<DropdownUserAttribute> {
  bool editable = false;
  String? selectedInCategory;

  bool render(UsersProvider usersProvider) {
    switch (widget.category) {
      case "portfolio":
        return usersProvider.selectedUser?.portfolio != 'null';
      case "faculty":
        return usersProvider.selectedUser?.facId != 'null';
      case "department":
        return usersProvider.selectedUser?.deptId != 'null';
      default:
        return true;
    }
  }

  @override
  void initState() {
    super.initState();
    selectedInCategory = 'selected' +
        widget.category.substring(0, 1).toUpperCase() +
        widget.category.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    return Selector<PortfolioProvider, Map<String, dynamic>?>(
      selector: (context, provider) {
        switch (widget.category) {
          case "portfolio":
            return provider.portfolios;
          case "faculty":
            return provider.faculties;
          case "department":
            return provider.departments;
        }
      },
      builder: (context, categoryObject, child) {
        return !render(usersProvider)
            ? Container()
            : Container(
                child: ListTile(
                  title: editable
                      ? DropdownButton<String>(
                          icon: const Icon(Icons.arrow_drop_down_sharp),
                          iconSize: 24,
                          elevation: 16,
                          isExpanded: true,
                          iconEnabledColor: Colors.blue,
                          style: TextStyle(color: Colors.black),
                          underline: Container(
                            height: 2,
                            width: 20,
                            color: Colors.blueAccent,
                          ),
                          value: categoryObject![selectedInCategory],
                          onChanged: (String? newValue) {
                            setState(() {
                              categoryObject[selectedInCategory!] = newValue;
                            });
                          },
                          items: categoryObject[widget.category == 'faculty'
                                  ? 'faculties'
                                  : widget.category + 's']
                              .map<DropdownMenuItem<String>>((categoryValue) {
                            return DropdownMenuItem<String>(
                              value: widget.category == "portfolio"
                                  ? categoryValue['name']
                                  : categoryValue['id'].toString(),
                              child: Text(categoryValue['name']),
                            );
                          }).toList(),
                        )
                      : attributeTextField(
                          widget.category,
                          editable,
                          TextEditingController(
                            text: widget.category == "portfolio"
                                ? categoryObject![selectedInCategory]
                                : categoryObject![widget.category == 'faculty'
                                            ? 'faculties'
                                            : widget.category + 's']
                                        .firstWhere((element) =>
                                            element['id'].toString() ==
                                            categoryObject[selectedInCategory])[
                                    'name'],
                          ),
                        ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        editable = true;
                        if (!usersProvider.userEdited)
                          usersProvider.updateUserEdited(true);
                      });
                    },
                  ),
                ),
              );
      },
    );
  }
}
