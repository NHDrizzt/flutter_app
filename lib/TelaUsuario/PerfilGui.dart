import 'package:flutter/material.dart';
import 'package:flutter_app/Rota/auth_provider.dart';
import 'package:flutter_app/Rota/authentication.dart';
import 'package:flutter_app/TelaUsuario/Perfil.dart';
import 'PageState.dart';
import 'Perfil.dart';

class Guillotine extends StatefulWidget {
  @override
  _GuillotineState createState() => _GuillotineState();
}

class _GuillotineState extends State<Guillotine> {
  _GuillotineState({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  Future<void> _signOut(BuildContext context) async {
    try{
      final BaseAuth auth = AuthProvider.of(context).auth;
      await auth.signOut();
      onSignedOut();
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: new Container(
        child: new Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            new Page(),
            new Perfil(),
          ],
        ),
      ),
    );
  }
}