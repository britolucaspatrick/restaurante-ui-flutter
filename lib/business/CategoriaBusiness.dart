import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_ui_kit/model/categoria.dart';

class CategoriaBusiness {

  static Future<List<Categoria>> getCategorias() async{
    List<Categoria> list = new List<Categoria>();
    await Firestore.instance
        .collection("categorias")
        .where('st_registro', isEqualTo: 1)
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((f) {
          list.add(Categoria.fromJson(f.data));
      });

      return list;
    });
  }
}