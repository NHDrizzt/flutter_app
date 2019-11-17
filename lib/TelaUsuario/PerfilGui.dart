import 'package:flutter/material.dart';
import 'package:flutter_app/TelaUsuario/Perfil.dart';
import 'UserOptions/PageState.dart';
import 'Perfil.dart';

class Guillotine extends StatefulWidget {
  @override
  _GuillotineState createState() => _GuillotineState();
}

class _GuillotineState extends State<Guillotine> {
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
