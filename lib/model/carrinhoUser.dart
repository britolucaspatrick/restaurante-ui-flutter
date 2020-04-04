import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_ui_kit/model/produto.dart';

class CarrinhoUser {
  String userID;
  List<Produto> prodCarrinho;

  CarrinhoUser({
    this.userID,
    this.prodCarrinho
  });

  Map<String, Object> toJson() {
    return {
      'userID' : userID,
      'prodCarrinho' : prodCarrinho,
    };
  }

  factory CarrinhoUser.fromJson(Map<String, Object> doc) {
    CarrinhoUser carrinhoUser = new CarrinhoUser(
      userID: doc['userID'],
      prodCarrinho: doc['prodCarrinho'],
    );
    return carrinhoUser;
  }

  factory CarrinhoUser.fromDocument(DocumentSnapshot doc) {
    return CarrinhoUser.fromJson(doc.data);
  }

}