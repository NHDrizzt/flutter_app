
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'Login.dart';
import 'SecondRoute.dart';
import 'TabBarAnimation.dart';

void main() => runApp(MaterialApp(home: BottomNavBar()));

class BottomNavBar extends StatefulWidget{
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>{
  int _page = 0;

  final _pageOption = [
    TabBarAnimation(),
    SecondRoute(),
    LoginPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
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

Card _cardFactory(int value, String txt) {
  return Card(
    color: Colors.lightBlueAccent[value],
    margin: const EdgeInsets.all(32.0),
    child: Container(
      margin: const EdgeInsets.all(30.0),
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Center(
            child: Text("$txt"),
          ),
        ],
      ),
    ),
  );
}

/*
class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
              Text('Boora HORA DO SHOW PORRA'),
            ]
        ),
      ),
      resizeToAvoidBottomPadding: false,
      body: ListView(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Card(
                  child: new InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TabBarAnimation()),
                      );
                    },
                    child: ListTile(
                      leading: Icon(Icons.thumb_up),
                      title: Center(
                          child: Text('Clique aqui para calcular seu Ip de rede')),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _cardFactory(5, 'Veja mais'),
          _cardFactory(5, 'Klassique'),
          _cardFactory(5, 'Uhum'),
          _cardFactory(5, 'Já sabe né'),
        ],
      ),

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,
        items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.compare_arrows, size: 30),
        ],
        onTap: (index) {
          //Handle button tap
        },
      ),

    );
  }
}
*/