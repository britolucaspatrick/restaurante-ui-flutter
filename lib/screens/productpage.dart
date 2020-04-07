import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/business/CarrinhoBusiness.dart';
import 'package:restaurant_ui_kit/business/auth.dart';
import 'package:restaurant_ui_kit/model/produto.dart';
import 'package:restaurant_ui_kit/screens/main_screen.dart';
import 'package:restaurant_ui_kit/shared/buttons.dart';
import 'package:restaurant_ui_kit/shared/styles.dart';
import 'package:restaurant_ui_kit/widgets/alert.dart';
import 'package:restaurant_ui_kit/widgets/smooth_star_rating.dart';

class ProductPage extends StatefulWidget {
  final String pageTitle;
  final Produto productData;

  ProductPage({Key key, this.pageTitle, this.productData}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  double _rating = 4;
  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF4F7FA),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xffF4F7FA),
          centerTitle: true,
          leading: BackButton(
            color: Colors.black54,
          ),
          title: Text(widget.productData.nome, style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700)
          ),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                          margin: EdgeInsets.only(top: 100, bottom: 100),
                          padding: EdgeInsets.only(top: 100, bottom: 50),
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 10, left: 10),
                                child: Text(
                                  widget.productData.nome,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,

                                ),
                              ),
                              Text(r'R$ ' + widget.productData.vl_unitario.toString().replaceAll('.', ','), style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5, bottom: 20),
                                child: SmoothStarRating(
                                  allowHalfRating: false,
                                  onRatingChanged: (v) {
                                    setState(() {
                                      _rating = v;
                                    });
                                  },
                                  starCount: 5,
                                  rating: _rating,
                                  size: 27.0,
                                  color: Colors.orange,
                                  borderColor: Colors.orange,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 25),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Text('Quantidade', style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)
                                      ),
                                      margin: EdgeInsets.only(bottom: 15),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: 55,
                                          height: 55,
                                          child: OutlineButton(
                                            onPressed: () {
                                              setState(() {
                                                if (_quantity < widget.productData.qt_estoque)
                                                  _quantity += 1;
                                                else Alert.showAlertDialog(context, 'Ops! No momento só temos ${_quantity} unidades em estoque.', 2);
                                              });
                                            },
                                            child: Icon(Icons.add),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                          EdgeInsets.only(left: 20, right: 20),
                                          child: Text(_quantity.toString(), style: h3),
                                        ),
                                        Container(
                                          width: 55,
                                          height: 55,
                                          child: OutlineButton(
                                            onPressed: () {
                                              setState(() {
                                                if(_quantity == 1) return;
                                                _quantity -= 1;
                                              });
                                            },
                                            child: Icon(Icons.remove),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 180,
                                child: froyoFlatBtn('Adicionar no carrinho', () {
                                  try{
                                    CarrinhoBusiness.postNewProductCarrinho(
                                        prodID: widget.productData.documentID,
                                        prodQtd: _quantity,
                                        prodVl: widget.productData.vl_unitario);
                                    Alert.showAlertDialog(context, 'Produto adicionado no carrinho com sucesso', 1);
                                  }catch (ex){
                                    String msg = Auth.getExceptionText(ex);
                                    Alert.showAlertDialog(context, msg, 0);
                                  }
                                }),
                              ),
                              Container(
                                width: 180,
                                child: froyoOutlineBtn('Voltar ao menu', () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
                                }),
                              ),
                            ],
                          ),
                          decoration: boxDecorationContainer
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 3.6,
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              "${widget.productData.url_imagem}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
    )
    ;




  }
}

