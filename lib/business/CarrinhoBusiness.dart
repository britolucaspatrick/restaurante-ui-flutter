import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_ui_kit/model/produto.dart';

class CarrinhoBusiness {

  static void postNewProductCarrinho({String prodID, int prodQtd, double prodVl}) async {
    FirebaseAuth.instance.currentUser().then((user) async {
        await Firestore.instance.document('/carrinhoUser/${user.uid}/produtos/${prodID}').setData(ProductCarrinho(qtd: prodQtd, vl_unitario: prodVl).toJson());
    });
  }
}
