import 'package:flutter/material.dart';

class Alert {

  static void showAlertDialog(BuildContext context, String msg, int code) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
                height: 300,
                width: 250,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(code == 0 ? 'assets/cancel.png' : 'assets/tick.png', width: 90, height: 90, ),
                      SizedBox(width: 10, height: 10,),
                      Text(msg,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: code == 0 ? Colors.red : Colors.green, fontFamily: 'Poppins', fontSize: 15)
                      ),
                      SizedBox(width: 10, height: 10),
                      FlatButton(
                        child: Text("OK",
                            style: TextStyle(
                                color: code == 0 ? Colors.red : Colors.green, fontFamily: 'Poppins', fontSize: 15)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                )
            ),
          );
        }
    );
  }
}