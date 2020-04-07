import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:restaurant_ui_kit/business/auth.dart';
import 'package:restaurant_ui_kit/model/pessoa.dart';
import 'package:restaurant_ui_kit/screens/loginpage.dart';
import 'package:restaurant_ui_kit/widgets/alert.dart';
import 'package:restaurant_ui_kit/widgets/entryField.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController cep = new MaskedTextController(mask: '00.000-000',);
  TextEditingController cpf = new MaskedTextController(mask: '000.000.000-00',);
  TextEditingController log = new TextEditingController();
  TextEditingController bai = new TextEditingController();
  TextEditingController num = new TextEditingController();
  TextEditingController com = new TextEditingController();
  TextEditingController nome = new TextEditingController();
  TextEditingController telefone = new MaskedTextController(mask: '(00) 0 0000-0000',);
  FirebaseUser user;
  String url = '';

  @override
  void initState() {
    super.initState();

    getPessoa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          if (_formKey.currentState.validate()){
            Auth.addUser(new Pessoa(url_perfil: url, userID: user.uid, nome: nome.text, telefone: telefone.text, cpf: cpf.text, logradouro: log.text, cep: cep.text, bairro: bai.text, numero: num.text, complemento: com.text));
            Alert.showAlertDialog(context, 'Salvo com sucesso', 1);
          }
        },
        child: Icon(Icons.cloud_upload,),
        tooltip: 'Salvar',
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      backgroundImage: url != null || url != ''
                          ? NetworkImage(url)
                          : AssetImage("assets/adduser.png"),
                    ),
                    width: 100,
                    height: 100,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              nome.text,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 5.0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              user == null ? '' : user?.email == null ? '' : user?.email,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (BuildContext context){
                                      return LoginPage();
                                    },
                                  ),
                                );
                              },
                              child: Text("Sair",
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).accentColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    flex: 3,
                  ),
                ],
              ),

              Divider(),

              ListTile(
                title: Text(
                  "Informações da conta".toUpperCase(),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.edit,
                    size: 20.0,
                  ),
                ),
              ),

              EntryField(title: 'Nome Completo', controller: nome,),
              EntryField(title: 'Telefone', controller: telefone,),
              EntryField(title: 'CPF', controller: cpf,),

              Divider(),
              ListTile(
                title: Text(
                  "Endereço de entrega".toUpperCase(),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.edit,
                    size: 20.0,
                  ),
                ),

              ),
              EntryField(title: 'Logradouro', controller: log,),
              EntryField(title: 'CEP', controller: cep,),
              EntryField(title: 'Bairro', controller: bai,),
              EntryField(title: 'Número', controller: num,),
              EntryField(title: 'Complemento', controller: com, validator: false,),


            ],
          ),
        ),
      )
    );
  }

  void getPessoa() async {
    Auth.getCurrentFirebaseUser().then((onValue) {
      setState(() {
        user = onValue;
      });

      Stream<Pessoa> pessoa = Auth.getUser(user.uid);
      pessoa.forEach((f){
        setState(() {
          url = f.url_perfil;
          nome.text = f.nome;
          telefone.text = f.telefone;
          cpf.text = f.cpf;

          log.text = f.logradouro;
          bai.text = f.bairro;
          num.text = f.numero;
          cep.text = f.cep;

        });
      });
    });
  }
}

