
import 'package:cloud_firestore/cloud_firestore.dart';

class Categoria{
  int posicao;
  String documentID;
  String nome;
  String url_categoriaicon;
  int st_registro; //0 - nao usado 1 - usado

  Categoria({
    this.nome,
    this.posicao,
    this.documentID,
    this.url_categoriaicon,
    this.st_registro,
  });

  Map<String, Object> toJson() {
    return {
      'nome' : nome,
      'posicao' : posicao,
      'documentID' : documentID,
      'url_categoriaicon' : url_categoriaicon,
      'st_registro' : st_registro,
    };
  }

  factory Categoria.fromJson(Map<String, Object> doc) {
    Categoria categoria = new Categoria(
      nome: doc['nome'],
      posicao: doc['posicao'],
      documentID: doc['documentID'],
      url_categoriaicon: doc['url_categoriaicon'],
      st_registro: doc['st_registro'],
    );
    return categoria;
  }

  factory Categoria.fromDocument(DocumentSnapshot doc) {
    return Categoria.fromJson(doc.data);
  }
}