import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Model/Anime.dart';
import 'package:flutter_app/Model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Instancia do Firebase
final FirebaseAuth _firebaseAuthInstance = FirebaseAuth.instance;
final Firestore _fireStoreInstance = Firestore.instance;

class FirebaseLoginSet {
  Future<String> login(String email, String password) async {
    AuthResult result;
    try {
      result = await _firebaseAuthInstance.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user.uid;
    } on PlatformException catch (e) {
      print(e.code);
      return e.code;
    }
  }

  Future<bool> create(User newUser) async {
//O método "FetchSignInMethodsForEmail" vai retornar uma lista de métodos que o usuario pode usar para acessar
//Vai retornar 'null' se o usuário não for encontrado
    List<String> userverify = await _firebaseAuthInstance
        .fetchSignInMethodsForEmail(email: newUser.email);

    //Se a lista auxiliar estiver nula, o usuário não está cadastrado ainda
    if (userverify.isEmpty) {
      //O método 'CreateUserWithEmailAndPassWord' faz tudo pra mim, só preciso passar duas string pra ele, o email e a senha
      AuthResult result =
          await _firebaseAuthInstance.createUserWithEmailAndPassword(
        email: newUser.email,
        password: newUser.password,
      );
      final FirebaseUser user = result.user;
      //Função responsável por adicionar uma chave no Database, com info do user
      _regUserInStorage(newUser);
      return true;
    } else {
      //Usuario já está cadastrado!
      return false;
    }
  }

  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseAuthInstance.currentUser();
    return user.email;
  }

  Future<String> _regUserInStorage(User newUser) async {
    await _fireStoreInstance
        .collection('User')
        .document(newUser.email)
        .setData({
      "Name": newUser.name,
      "NickName": newUser.nickname,
      "Email": newUser.email,
    });
  }

  Future<bool> addToFavorites(DocumentSnapshot doc) async {
    Anime newFavAnime = new Anime(doc["Nome"], doc['Estudio'], doc["Duracao"],
        doc["Categoria"], doc["Descricao"]);

    String email = await currentUser();
    await _fireStoreInstance
        .collection('User')
        .document(email)
        .collection('AnimesFavoritos')
        .document(newFavAnime.NomeAnime)
        .setData({
      "Nome": newFavAnime.NomeAnime,
      "Estudio": newFavAnime.Estudio,
      "Duracao": newFavAnime.Duracao,
      "Categoria": newFavAnime.Categoria,
      "Descricao": newFavAnime.Descricao,
    }).catchError((e) {
      return false;
    });
    return true;
  }

  Future<bool> addToAssistidos(DocumentSnapshot doc) async {
    Anime newFavAnime = new Anime(doc["Nome"], doc['Estudio'], doc["Duracao"],
        doc["Categoria"], doc["Descricao"]);

    String email = await currentUser();
    _fireStoreInstance
        .collection('User')
        .document(email)
        .collection('Assistidos')
        .document(newFavAnime.NomeAnime)
        .setData({
      "Nome": newFavAnime.NomeAnime,
      "Estudio": newFavAnime.Estudio,
      "Duracao": newFavAnime.Duracao,
      "Categoria": newFavAnime.Categoria,
      "Descricao": newFavAnime.Descricao,
    }).then((value) {
      return true;
    }).catchError((e) {
      return false;
    });
  }

  Future<bool> addToAssistindo(
      DocumentSnapshot doc, String temp, String ep) async {
    Anime newFavAnime = new Anime(doc["Nome"], doc['Estudio'], doc["Duracao"],
        doc["Categoria"], doc["Descricao"]);

    String email = await currentUser();
    _fireStoreInstance
        .collection('User')
        .document(email)
        .collection('SendoAssistido')
        .document(newFavAnime.NomeAnime)
        .setData({
      "Nome": newFavAnime.NomeAnime,
      "Categoria": newFavAnime.Categoria,
      "UltimoEp": ep,
      "UltimaTemp": temp,
    });
  }

  Future<bool> addToWatchLater(DocumentSnapshot doc) async {
    Anime newFavAnime = new Anime(doc["Nome"], doc['Estudio'], doc["Duracao"],
        doc["Categoria"], doc["Descricao"]);

    String email = await currentUser();
    _fireStoreInstance
        .collection('User')
        .document(email)
        .collection('AssistirMaisTarde')
        .document(newFavAnime.NomeAnime)
        .setData({
      "Nome": newFavAnime.NomeAnime,
      "Estudio": newFavAnime.Estudio,
      "Duracao": newFavAnime.Duracao,
      "Categoria": newFavAnime.Categoria,
      "Descricao": newFavAnime.Descricao,
    }).then((value) {
      return true;
    }).catchError((e) {
      return false;
    });
  }
}

class FirebaseGET {}
