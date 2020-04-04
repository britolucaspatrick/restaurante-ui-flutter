import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget{
  final Function ontap;
  final String textButton;

  const SubmitButton(
      {
        Key key,
        @required this.ontap,
        @required this.textButton,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontap;
        Navigator.pop(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color.fromRGBO(68, 208, 98, 1), Color.fromRGBO(61, 158, 88, 1)])),
        child: Text(
          textButton,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

}