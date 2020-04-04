import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_ui_kit/model/pessoa.dart';

class AvaliacoesProduto {

  String produtoID;
  Timestamp dt_lanct;
  String descricao;
  double rate;
  String userID;

  Pessoa pessoa;

  AvaliacoesProduto({
    this.produtoID,
    this.descricao,
    this.userID,
    this.dt_lanct,
    this.rate
  });

  Map<String, Object> toJson() {
    return {
      'produtoID' : produtoID,
      'descricao' : descricao,
      'userID' : userID,
      'dt_lanct': dt_lanct,
      'rate': rate,
    };
  }

  factory AvaliacoesProduto.fromJson(Map<String, Object> doc) {
    AvaliacoesProduto ava = new AvaliacoesProduto(
      produtoID: doc['produtoID'],
      descricao: doc['descricao'],
      userID: doc['userID'],
      dt_lanct: doc['dt_lanct'],
      rate: doc['rate'],
    );
    return ava;
  }

  factory AvaliacoesProduto.fromDocument(DocumentSnapshot doc) {
    return AvaliacoesProduto.fromJson(doc.data);
  }
}