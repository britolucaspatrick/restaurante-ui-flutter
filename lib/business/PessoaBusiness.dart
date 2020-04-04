import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_ui_kit/model/pessoa.dart';

class PessoaBusiness{

/*  static Stream<Pessoa> getPessoa(String id) {
    Firestore.instance
        .collection("pessoas")
        //.where('userID', isEqualTo: id)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      snapshot.documents.map((doc) {
        return Pessoa.fromDocument(doc);
      }).first;
    });
  }*/

  static Future<bool> checkPessoaExist(String id) async {
    bool exists = false;
    try {
      await Firestore.instance.document("pessoas/$id").get().then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  static void addPessoa(String id, String name, String cpf) async {
    print(id);
    Pessoa pessoa = Pessoa(userID: id, nome: name, cpf: cpf);

    checkPessoaExist(id).then((value) {
      if (!value) {
        Firestore.instance.collection("pessoas").add(pessoa.toJson()).then((ref){
          pessoa.userID = ref.documentID;
          Firestore.instance.collection("pessoas").document(ref.documentID).updateData(pessoa.toJson());
        });
      } else {
        Firestore.instance.document('pessoas/${id}').updateData(pessoa.toJson());
      }
    });
  }

/*static Future<void> post(String id, String name, String cpf, File _image){
    Pessoa pessoa = Pessoa(id:id, nome: name, cpf: int.parse(cpf.replaceAll('.', '').replaceAll('-', '')));
      Firestore.instance.collection("pessoa").add(pessoa.toJson()).then((ref){
        pessoa.documentID = ref.documentID;
        return Firestore.instance.collection("pessoa").document(ref.documentID).updateData(pessoa.toJson());
        //saveImage(_image, ref.documentID, pessoa);
    });
  }

  static Future<String> saveImage(File _image, String documentID, Pessoa pessoa) async {
    String path = 'pessoaUrlPerfil/${documentID}';
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child(path);
    StorageUploadTask uploadTask = storageReference.putFile(_image);

    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((v){
      updateUrlImagem(documentID, pessoa, v);
    });
  }

  static updateUrlImagem(String documentID, Pessoa pessoa, String value) async{
    pessoa.url_perfil = value;
    Firestore.instance.collection("pessoa").document(documentID).updateData(pessoa.toJson());
  }*/
}