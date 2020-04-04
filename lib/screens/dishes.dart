import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_ui_kit/model/produto.dart';
import 'package:restaurant_ui_kit/screens/notifications.dart';
import 'package:restaurant_ui_kit/widgets/badge.dart';
import 'package:restaurant_ui_kit/widgets/grid_product.dart';

class DishesScreen extends StatefulWidget {
  @override
  _DishesScreenState createState() => _DishesScreenState();
}

class _DishesScreenState extends State<DishesScreen> {
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
          .where('isOferta', isEqualTo: true)
          .getDocuments()
          .then((querySnapshot) {
        querySnapshot.documents.forEach((f) {
          setState(() {
            f.data["documentID"] = f.documentID;
            produtos.add(Produto.fromJson(f.data));
            print(produtos);
          });
        });
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {}
    }
  }

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
          "Ofertas",
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
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
              ),
              itemCount: produtos == null ? 0 : produtos.length,
              itemBuilder: (BuildContext context, int index) {
                return GridProduct(producto: produtos[index],);
              },
            ),
          ],
        ),
      ),
    );
  }
}
