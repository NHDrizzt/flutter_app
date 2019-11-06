import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

//Instancia do Firebase
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class FirebaseUs {
  Future<String> login(String email, String password) async {
    AuthResult result;
    try {
      result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user.uid;
    } on PlatformException catch (e) {
      print(e.code);
      return e.code;
    }
  }

  Future<String> create(String email, String password) async {
//O método "FetchSignInMethodsForEmail" vai retornar uma lista de métodos que o usuario pode usar para acessar
//Vai retornar 'null' se o usuário não for encontrado
    List<String> userverify =
        await _firebaseAuth.fetchSignInMethodsForEmail(email: email);

    //Se a lista auxiliar estiver nula, o usuário não está cadastrado ainda
    if (userverify.isEmpty) {
      //Cadastro FIREBASE

      //O método 'CreateUserWithEmailAndPassWord' faz tudo pra mim, só preciso passar duas string pra ele, o email e a senha
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final FirebaseUser user = result.user;
      var x = user.uid;
      return x;
    } else {
      //Usuario já está cadastrado!
      return null;
    }
  }

  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }
}
