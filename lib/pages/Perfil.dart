import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/pages/Login.dart';
import 'package:flutter_app/pages/PerfilGui.dart';
import 'dart:math';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => new _PerfilState();
}


class _PerfilState extends State<Perfil> with SingleTickerProviderStateMixin {
  AnimationController animationControllerMenu;
  Animation<double> animationMenu;
  Animation<double> animationTitleFadeInOut;
  _GuillotineAnimationStatus menuAnimationStatus = _GuillotineAnimationStatus.closed;


  void _playAnimation() {
    try {
      if (menuAnimationStatus == _GuillotineAnimationStatus.animating) {
        // During the animation, do not do anything
      } else if (menuAnimationStatus == _GuillotineAnimationStatus.closed) {
        animationControllerMenu.forward().orCancel;
      } else {
        animationControllerMenu.reverse().orCancel;
      }
    } on TickerCanceled {
      // the animation go cancelled, probably because disposed
    }
  }

  @override
  void initState(){
    super.initState();
    menuAnimationStatus = _GuillotineAnimationStatus.closed;
    animationControllerMenu = new AnimationController(
        duration: const Duration(
          milliseconds: 1000,
        ),
        vsync: this)
      ..addListener(() {});
    animationMenu =
    new Tween(begin: -pi / 2.0, end: 0.0).animate(new CurvedAnimation(
      parent: animationControllerMenu,
      curve: Curves.bounceOut,
      reverseCurve: Curves.bounceIn,
    ))
      ..addListener(() {
        setState(() {
          // force refresh
        });
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          menuAnimationStatus = _GuillotineAnimationStatus.open;
        } else if (status == AnimationStatus.dismissed) {
          menuAnimationStatus = _GuillotineAnimationStatus.closed;
        } else {
          menuAnimationStatus = _GuillotineAnimationStatus.animating;
        }
      });
    animationTitleFadeInOut = new Tween(
        begin: 1.0,
        end: 0.0
    ).animate(new CurvedAnimation(
        parent: animationControllerMenu,
        curve: new Interval(
        0.0,
        0.5,
        curve: Curves.ease,
    ),
    ));
  }

  @override
  void dispose(){
    animationControllerMenu.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double angle = animationMenu.value;

    return new Transform.rotate(
      angle: angle,
      origin: new Offset(24.0, 56.0),
      alignment: Alignment.topLeft,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: screenWidth,
          height: screenHeight,
          color: Color(0xFF333333),
          child: new Stack(
            children: <Widget>[
              _buildMenuTitle(),
              _buildMenuIcon(),
              _buildMenuContent(),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuTitle(){
    return new Positioned(
      top: 32.0,
      left: 40.0,
      width: 400.0,
      height: 24.0,
      child: new Transform.rotate(
          alignment: Alignment.topLeft,
          origin: Offset.zero,
          angle: pi / 2.0,
          child: new Center(
            child: new Container(
              width: double.infinity,
              height: double.infinity,
              child: new Opacity(
                opacity: animationTitleFadeInOut.value,
                child: new Text('Minha Biblioteca',
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    )),
              ),
            ),
          )),
    );
  }

  Widget _buildMenuIcon(){
    return new Positioned(
      top: 32.0,
      left: 4.0,
      child: new IconButton(
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        onPressed: _playAnimation,
      ),
    );
  }

  Widget _buildMenuContent(){
    final List<Map> _menus = <Map>[
      {
        "icon": Icons.person,
        "title": "Perfil",
        "color": Colors.white,
      },
      {
        "icon": Icons.view_agenda,
        "title": "Minha Biblioteca",
        "color": Colors.white,
      },
      {
        "icon": Icons.star,
        "title": "Favoritos",
        "color": Colors.cyan,
      },
      {
        "icon": Icons.timelapse,
        "title": "Assistindo",
        "color": Colors.white,
      },
      {
        "icon": Icons.timer,
        "title": "Assistidos",
        "color": Colors.white,
      },
      {
        "icon": Icons.exit_to_app,
        "title": "Desconectar",
        "color": Colors.white,
      },

    ];

    return new Padding(
      padding: const EdgeInsets.only(left: 64.0, top: 96.0),
      child: new Container(
        width: double.infinity,
        height: double.infinity,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _menus.map((menuItem) {
            return new ListTile(
              leading: new Icon(
                menuItem["icon"],
                color: menuItem["color"],
              ),
              title: GestureDetector(
                child: new Text(
                  menuItem["title"],
                  style: new TextStyle(
                      color: menuItem["color"],
                      fontSize: 24.0),
                ),
                onTap: (){
                  if (menuItem["title"] == "Minha Biblioteca"){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Guillotine()),
                    );
                  }
                else if(menuItem["title"] == "Desconectar"){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BottomNavBar()),
                    );
                  }
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}


enum _GuillotineAnimationStatus { closed, open, animating }