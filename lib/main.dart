import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_app/TelaUsuario/Perfil.dart';
import 'package:flutter_app/TelaUsuario/PerfilGui.dart';
import 'package:flutter_app/TelaNavBar/Cadastro/Register.dart';
import 'package:flutter_app/Rota/authentication.dart';
import 'package:flutter_app/Rota//root_page.dart';
import 'Library/Andetails.dart';
import 'TelaNavBar/Login.dart';
import 'TelaNavBar/SecondRoute.dart';
import 'TelaNavBar/TabBarAnimation.dart';


void main() => runApp(MaterialApp(
      home: BottomNavBar(),
      routes: {
        '/Inicial': (context) => TabBarAnimation(),
        '/Library': (context) => SecondRoute(),
        '/Login': (context) => LoginPage(),
        '/Details': (context) => detailsAnime(),
        '/Register': (context) => RegisterPage(),
        '/Perfil': (context) => Perfil(),
        '/Guilhotina': (context) => Guillotine(),
      },
    ));

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;

  final _pageOption = [
    LoginPage(),
    SecondRoute(),
    //new RootPage(auth: new Auth()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.compare_arrows, size: 30),
        ],
        color: Colors.orange,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.orangeAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: _pageOption[_page],
    );
  }
}
