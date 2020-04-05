import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/model/produto.dart';
import 'package:restaurant_ui_kit/screens/checkout.dart';
import 'package:restaurant_ui_kit/widgets/cart_item.dart';
import 'package:restaurant_ui_kit/widgets/nodata.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with AutomaticKeepAliveClientMixin<CartScreen >{
  List<ProductCarrinho> prodCar = new List<ProductCarrinho>();

  @override
  void initState() {
    super.initState();

    getCarrinho();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            Text(
              "Carrinho",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 10.0),
            prodCar != null || prodCar.length > 0 ?
            Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: prodCar.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CartItem(
                        img: prodCar[index].url_produc.toString(),
                        name: prodCar[index].nome.toString(),
                        vl_unitario: prodCar[index].vl_unitario.toString().replaceAll('.', ','),
                        qtd: prodCar[index].qtd
                    );
                  },
                )
            )
                :
            NoData(
              labelText: 'Nenhum serviço!',
            )
          ],
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

  void getCarrinho() async {
    FirebaseAuth.instance.currentUser().then((user) async {
      await Firestore.instance
          .collection('carrinhoUser')
          .document('${user.uid}')
          .collection('produtos')
          .getDocuments()
          .then((querySnapshot) {
        querySnapshot.documents.forEach((f) {

          //BUSCAR O NOME, URL DO PRODUTO
          Firestore.instance.collection('produtos').document('${f.documentID}').get().then((aa){
            Produto aux = Produto.fromJson(aa.data);
            QtSellCarrinho qtSell = QtSellCarrinho.fromJson(f.data);
            setState(() {
              prodCar.add(new ProductCarrinho(
                  qtd: qtSell.qtd,
                  vl_unitario: qtSell.vl_unitario,
                  url_produc: aux.url_imagem,
                  nome: aux.nome
              ));
            });
          });
        });
      });
    });
  }

}
