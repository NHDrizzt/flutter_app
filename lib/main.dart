
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_app/pages/Perfil.dart';
import 'package:flutter_app/pages/authentication.dart';
import 'package:flutter_app/pages/root_page.dart';
import 'pages/Login.dart';
import 'pages/SecondRoute.dart';
import 'pages/TabBarAnimation.dart';
import 'pages/Library/Andetails.dart';


void main() => runApp(MaterialApp(
  home: BottomNavBar(),
    routes:{
      '/Inicial' : (context) => TabBarAnimation(),
      '/Library' : (context) => SecondRoute(),
      '/Login' : (context) => LoginPage(),
      '/Details' : (context) => detailsAnime()
    } ,
    ));

class BottomNavBar extends StatefulWidget{
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>{
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
        onTap:(index){
          setState(() {
            _page = index;
          });
        },
      ),
      body: _pageOption[_page],
    );
  }
}
