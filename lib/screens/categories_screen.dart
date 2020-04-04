import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_ui_kit/model/categoria.dart';
import 'package:restaurant_ui_kit/model/produto.dart';
import 'package:restaurant_ui_kit/screens/notifications.dart';
import 'package:restaurant_ui_kit/widgets/badge.dart';
import 'package:restaurant_ui_kit/widgets/grid_product.dart';
import 'package:restaurant_ui_kit/widgets/home_category.dart';

class CategoriesScreen extends StatefulWidget {
  Categoria categoriaSeleted;

  CategoriesScreen({Key key, this.categoriaSeleted}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Categoria> categories = new List<Categoria>();
  List<Produto> produtos = new List<Produto>();

  bool possuiServico = false;

  @override
  void initState() {
    super.initState();
    getCategorias();
    getProdutos();

  }

  getProdutos() async {
    try {
      produtos.clear();
      await Firestore.instance
          .collection("produtos")
          .where('categoriaID', isEqualTo: widget.categoriaSeleted.documentID)
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

  getCategorias() async {
    try {
      categories.clear();
      possuiServico = false;
      await Firestore.instance
          .collection("categorias")
          .getDocuments()
          .then((querySnapshot) {
        querySnapshot.documents.forEach((f) {
          setState(() {
            f.data["documentID"] = f.documentID;
            categories.add(Categoria.fromJson(f.data));
            possuiServico = true;
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
          "Categorias",
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
            Container(
              height: 65.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: categories == null ? 0 : categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: HomeCategory(
                      icon: Image(
                        width: 30,
                        height: 30,
                        fit: BoxFit.fill,
                        image: NetworkImage(categories[index].url_categoriaicon),
                      ),
                      title: categories[index].nome,
                      items: '5',
                    ),
                    onTap: (){
                      setState(() {
                        widget.categoriaSeleted = categories[index];
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              widget.categoriaSeleted.nome,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            Divider(),
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
