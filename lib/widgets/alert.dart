import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/shared/styles.dart';

class Alert {

  //code 0 ERROR 1 CORRECT 2 INFORMATION 3 QUESTION

  static void showAlertDialog(BuildContext context, String msg, int code) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
                decoration: boxDecorationContainer,
                height: 300,
                width: 250,
                child: Card(
                  elevation: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        code == 0 ? 'assets/cancel.png' :
                        code == 1 ? 'assets/tick.png' :
                        code == 2 ? 'assets/info.png' :
                        'assets/question.png',
                        width: 90, height: 90, ),
                      SizedBox(width: 10, height: 10,),
                      Padding(
                        padding: EdgeInsets.only(right: 15, left: 15),
                        child: Text(msg,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color:
                                code == 0 ? Colors.red :
                                code == 1 ? Colors.green :
                                code == 2 ? Colors.blue :
                                Colors.blue,
                                fontSize: 15)
                        ),
                      ),
                      SizedBox(width: 15, height: 15),
                      FlatButton(
                        child: Text("OK",
                            style: TextStyle(
                                color:
                                code == 0 ? Colors.red :
                                code == 1 ? Colors.green :
                                code == 2 ? Colors.blue :
                                Colors.blue,
                                fontSize: 15)),
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