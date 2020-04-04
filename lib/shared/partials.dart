import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/model/produto.dart';
import 'package:restaurant_ui_kit/shared/color.dart';
import '../shared/styles.dart';

Widget foodItem(Produto food,
    {double imgWidth, bool isProductPage = false}) {

  return Container(
    // color: Colors.red,
    margin: EdgeInsets.only(left: 20),
    child: Stack(
      children: <Widget>[
        Container(
          color: Colors.white,

            width: 180,
            height: 180,
            child: RaisedButton(
                color: Colors.white,
                elevation: (isProductPage) ? 20 : 20,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Hero(
      transitionOnUserGestures: true,
      tag: food.nome,))),
        Positioned(
          bottom: 0,
          left: 0,
          child: (!isProductPage)
              ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(food.nome, style: foodNameText),
              Text(food.vl_unitario.toString().replaceAll('.', ','), style: priceText),
            ],
          )
              : Text(' '),
        ),
      ],
    ),
  );
}
