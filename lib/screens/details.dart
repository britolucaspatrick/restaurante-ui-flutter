import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/model/avaliacoesProduto.dart';
import 'package:restaurant_ui_kit/model/produto.dart';
import 'package:restaurant_ui_kit/screens/notifications.dart';
import 'package:restaurant_ui_kit/screens/productpage.dart';
import 'package:restaurant_ui_kit/util/const.dart';
import 'package:restaurant_ui_kit/widgets/badge.dart';
import 'package:restaurant_ui_kit/widgets/smooth_star_rating.dart';

class ProductDetails extends StatefulWidget {
  Produto produto;

  ProductDetails({Key key, this.produto}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  List<AvaliacoesProduto> comments = new List<AvaliacoesProduto>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: ()=>Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Detalhes",
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: IconBadge(
              icon: Icons.notifications,
              size: 22.0,
            ),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context){
                    return Notifications();
                  },
                ),
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3.2,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.produto.url_imagem,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Positioned(
                  right: -10.0,
                  bottom: 3.0,
                  child: RawMaterialButton(
                    onPressed: (){},
                    fillColor: Colors.white,
                    shape: CircleBorder(),
                    elevation: 4.0,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        widget.produto.isFav
                            ?Icons.favorite
                            :Icons.favorite_border,
                        color: Colors.red,
                        size: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.0),

            Text(
              widget.produto.nome,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
                  SmoothStarRating(
                    starCount: 5,
                    color: Constants.ratingBG,
                    allowHalfRating: true,
                    rating: widget.produto.rating,
                    size: 10.0,
                  ),
                  SizedBox(width: 10.0),

                  Text(
                    '${widget.produto.rating}',
                    style: TextStyle(
                      fontSize: 11.0,
                    ),
                  ),

                ],
              ),
            ),


            Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Quantidade mínima: ${widget.produto.qt_minimalsell}",
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(width: 10.0),

                  Text(
                    r"R$ " + widget.produto.vl_unitario.toString().replaceAll('.', ','),
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).accentColor,
                    ),
                  ),

                ],
              ),
            ),


            SizedBox(height: 20.0),

            Text(
              "Descrição",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),

            SizedBox(height: 10.0),

            Text(
              '${widget.produto.descricao}',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),

            SizedBox(height: 20.0),

            Text(
              "Avaliações",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            SizedBox(height: 20.0),

            comments.length > 0 ?
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              itemCount: comments == null?0:comments.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(comments[index].pessoa.url_perfil),
                    ),

                    title: Text("${comments[index].pessoa.nome}"),
                    subtitle: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SmoothStarRating(
                              starCount: 5,
                              color: Constants.ratingBG,
                              allowHalfRating: true,
                              rating: comments[index].rate,
                              size: 12.0,
                            ),
                            SizedBox(width: 6.0),
                            Text(
                              "${comments[index].dt_lanct.toDate()}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 7.0),
                        Text(
                          "${comments[index].descricao}",
                        ),
                      ],
                    ),
                );
              },
            ) :
            SizedBox(height: 10.0),
            SizedBox(height: 10.0),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        height: 50.0,
        child: RaisedButton(
          child: Text(
            "Adicionar no carrinho",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Theme.of(context).accentColor,
          onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context){
                  return ProductPage(productData: widget.produto,);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
