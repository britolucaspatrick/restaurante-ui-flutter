import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_ui_kit/model/produto.dart';
import 'package:restaurant_ui_kit/widgets/grid_product.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with AutomaticKeepAliveClientMixin<FavoriteScreen>{
  List<Produto> produtos = new List<Produto>();

  @override
  void initState() {
    super.initState();
    getProdutos();
  }

  getProdutos() async{
    try {
      produtos.clear();
      await Firestore.instance
          .collection("produtos")
          .getDocuments()
          .then((querySnapshot) {
        querySnapshot.documents.forEach((f) {
          setState(() {
            f.data["documentID"] = f.documentID;
            produtos.add(Produto.fromJson(f.data));
          });
        });
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {}
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            Text(
              "Favoritos",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 10.0),

            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
              ),
              itemCount: produtos == null ? 0 :produtos.length,
              itemBuilder: (BuildContext context, int index) {
                return GridProduct(producto: produtos[index],);
              },
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
