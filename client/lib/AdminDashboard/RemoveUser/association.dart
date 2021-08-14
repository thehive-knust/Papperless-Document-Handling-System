import 'package:flutter/material.dart';

class Association extends StatefulWidget {
  const Association({Key? key}) : super(key: key);

  @override
  _AssociationState createState() => _AssociationState();
}

class _AssociationState extends State<Association> {
  int? radioValue = 1;
TextEditingController? associationRoleController;
  void changeRadioButtonValue(int? value) {
    setState(() {
      radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Association Role",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        Spacer(),
        Expanded(
          flex: 4,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20),
                  child: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.only(right: 700.0),
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: associationRoleController,
                    decoration: InputDecoration(
                        filled: true,
                        hintText: ' Association Role',
                        hintStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w100,
                        ),
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide.none,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
        Spacer(
          flex: 2,
        ),
      ],
    );
  }
}
