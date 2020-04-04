import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_ui_kit/business/PessoaBusiness.dart';
import 'package:restaurant_ui_kit/business/auth.dart';
import 'package:restaurant_ui_kit/model/pessoa.dart';
import 'package:restaurant_ui_kit/screens/loginpage.dart';
import 'package:restaurant_ui_kit/screens/main_screen.dart';
import 'package:restaurant_ui_kit/widgets/alert.dart';
import 'package:restaurant_ui_kit/widgets/bezierContainer.dart';
import 'package:restaurant_ui_kit/widgets/entryField.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController email = new TextEditingController();
  TextEditingController senha = new TextEditingController();
  TextEditingController cpf = new MaskedTextController(mask: '000.000.000-00');
  TextEditingController nome = new TextEditingController();

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 5, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Voltar',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  void _signUp(
      {String fullname,
        String cpf,
        String email,
        String password,
        BuildContext context}) async {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await Auth.signUp(email, password).then((uID) {
          Auth.addUser(new Pessoa(
              userID: uID,
              nome: fullname,
              cpf: cpf));
        });
      } catch (e) {
        print("Error in sign up: $e");
        String exception = Auth.getExceptionText(e);
        Alert.showAlertDialog(context, exception, 0);
      }
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: (){
        _signUp(fullname: nome.text, cpf: cpf.text, email: email.text, password: senha.text, context: context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color.fromRGBO(68, 208, 98, 1), Color.fromRGBO(61, 158, 88, 1)])),
        child: Text(
          'Salvar',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Já tem uma conta? ',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),

          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text(
              'Entrar',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child:Container(
              height: MediaQuery.of(context).size.height,
              child:Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                    child: ListView(
                      children: <Widget>[
                        EntryField(controller: nome, title: 'Nome completo',),
                        EntryField(controller: email, title: 'Email'),
                        EntryField(controller: senha, title: 'Senha', isPassword: true,),
                        EntryField(controller: cpf, title: 'CPF',),
                        _submitButton(),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _loginAccountLabel(),
                  ),
                  Positioned(top: 40, left: 0, child: _backButton()),
                ],
              ),
            )
        )
    );
  }
}
