import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/animation/moveanimation.dart';
import 'package:restaurant_ui_kit/screens/details.dart';
import 'package:restaurant_ui_kit/util/const.dart';
import 'package:restaurant_ui_kit/widgets/smooth_star_rating.dart';

class CartItem extends StatelessWidget {
  final String name;
  final String img;
  final String vl_unitario;
  final int qtd;

  CartItem({
    Key key,
    @required this.name,
    @required this.img,
    @required this.vl_unitario,
    @required this.qtd})
      :super(key: key);
  @override
  Widget build(BuildContext context) {
    return MoveAnimation(
      duration: Duration(seconds: 3),
      child: GestureDetector(
        onTap: (){},
        child: Container(
          padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: Card(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 0.0, right: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.width/3.5,
                    width: MediaQuery.of(context).size.width/3.5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        "$img",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 5, top: 5),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "$name",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "$vl_unitario",
                            style: TextStyle(
//                    fontSize: 15,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Row(
                        children: <Widget>[
                      Text(
                      "Quantidade: ${qtd}",
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                        ],
                      ),
                ),
                  ],

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
