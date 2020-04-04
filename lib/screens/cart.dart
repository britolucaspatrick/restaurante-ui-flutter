import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/model/carrinhoUser.dart';
import 'package:restaurant_ui_kit/screens/checkout.dart';
import 'package:restaurant_ui_kit/widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with AutomaticKeepAliveClientMixin<CartScreen >{
  CarrinhoUser carrinho = new CarrinhoUser();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: ListView.builder(
          itemCount: carrinho.prodCarrinho == null ? 0 :carrinho.prodCarrinho.length,
          itemBuilder: (BuildContext context, int index) {
            return CartItem(
              img: carrinho.prodCarrinho[index].url_imagem,
              isFav: false,
              name: carrinho.prodCarrinho[index].nome,
              rating: 5.0,
              raters: 23,
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: "Checkout",
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context){
                return Checkout();
              },
            ),
          );
        },
        child: Icon(
          Icons.arrow_forward,
        ),
        heroTag: Object(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
