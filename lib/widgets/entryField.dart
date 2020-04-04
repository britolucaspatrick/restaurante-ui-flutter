import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EntryField extends StatelessWidget{
  String title;
  TextEditingController controller;
  bool isPassword;
  bool validator;
  bool autovalidate;

  EntryField({Key key, this.title, this.controller, this.isPassword = false, this.validator = true, this.autovalidate = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          TextFormField(
              validator: (value) {
                if (!validator)
                  return null;
                if (value == null || value == '' || value.isEmpty)
                  return 'Obrigatório informar';
              },
              autovalidate: autovalidate,
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

}