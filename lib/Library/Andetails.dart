import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Util/fancy.dart';
import 'package:flutter_app/Library/globals.dart' as globals;

class detailsAnime extends StatefulWidget {
  @override
  _detailAn createState() => _detailAn();
}

class _detailAn extends State<detailsAnime> {
  double widthContainer = 300.0;
  Icon icon = Icon(Icons.arrow_back_ios);
  Color bckcolor = Colors.transparent;
  Radius toprigthBorder = Radius.circular(5.0);
  Radius botrigthBorder = Radius.circular(130.0);

  //AppBar
  final _posAppbar = AppBar(
    actions: <Widget>[
      IconButton(
          icon: Icon(
            Icons.more_vert,
            color: Colors.orange,
          ),
          onPressed: () {
            /// FAZER
          })
    ],
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  );

  final _getGradient = Container(
    margin: new EdgeInsets.only(top: 170.0),
    height: 110.0,
    decoration: new BoxDecoration(
      gradient: new LinearGradient(
        colors: <Color>[new Color(0x00736AB7), new Color(0xFFFF9800)],
        stops: [0.0, 0.9],
        begin: const FractionalOffset(0.0, 0.0),
        end: const FractionalOffset(0.0, 1.0),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    DocumentSnapshot doc = ModalRoute.of(context).settings.arguments;

    final _icButtonCard = Container(
        alignment: Alignment.topRight,
        child: FloatingActionButton(
            child: icon,
            backgroundColor: Colors.transparent,
            elevation: 0,
            mini: true,
            foregroundColor: Colors.black,
            onPressed: () {
              setState(() {
                if (widthContainer == 15) {
                  botrigthBorder = Radius.circular(140.0);
                  toprigthBorder = Radius.circular(10.0);
                  widthContainer = 300;
                  icon = icon = Icon(Icons.arrow_back_ios);
                } else {
                  botrigthBorder = Radius.circular(200.0);
                  toprigthBorder = Radius.circular(200.0);
                  icon = null;
                  widthContainer = 15;
                }
              });
            }));

    //Card no meio da Tela
    final _centerCard = Positioned(
        top: 160.0,
        child: GestureDetector(
          onTap: () {
            setState(() {
              if (widthContainer == 15) {
                botrigthBorder = Radius.circular(140.0);
                toprigthBorder = Radius.circular(10.0);
                widthContainer = 300;
                icon = icon = Icon(Icons.arrow_back_ios);
              } else {
                botrigthBorder = Radius.circular(200.0);
                toprigthBorder = Radius.circular(200.0);
                widthContainer = 15;
                icon = null;
              }
            });
          },
          child: new AnimatedContainer(
            duration: Duration(milliseconds: 800),
            //padding: EdgeInsets.all(8.0),
            height: 180.0,
            width: widthContainer,
            child: Stack(
              children: <Widget>[
                _icButtonCard,
                _centerCardContainer(doc),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: botrigthBorder, topRight: toprigthBorder)),
          ),
        ));

    if(globals.isLoggedIn == true){
        return Scaffold(
          //    body: _body(doc, context),
          body: Stack(
            children: <Widget>[
              _img(doc, context),
              // _getGradient,
              _descAnime(doc),
              _posAppbar,
              _centerCard
            ],
          ),
          backgroundColor: Colors.orange,
        );

    }else if(globals.isLoggedIn == false){
      return Scaffold(
        //    body: _body(doc, context),
        body: Stack(
          children: <Widget>[
            _img(doc, context),
            // _getGradient,
            _descAnime2(doc),
            _posAppbar,
            _centerCard
          ],
        ),
        backgroundColor: Colors.orange,
      );
    }
  }
}
Widget _descAnime2(DocumentSnapshot doc) {
  return Positioned(
    top: 230.0,
    child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 70.0),
        padding: EdgeInsets.all(10.0),
        width: 400,
        height: 500,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            _txtContent(doc['Descricao'], 17, FontWeight.w400),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Opacity(
                    opacity: 1.0,
                    child: new FlatButton(
                        child: new Text("Você precisa estar LOGADO para adicionar Animes"),color: Colors.red, onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ],
        )),
  );
}

//Descrição do Anime
Widget _descAnime(DocumentSnapshot doc) {
  final fancybutton = Align(
    alignment: Alignment.bottomLeft,
    child: Container(
      child: FancyButton(
        child: Text(
          "Adicionar!",
          style: TextStyle(color: Colors.white),
        ),
        size: 18,
        color: Colors.black,
      ),
    ),
  );
  final fancybutton2 = Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      child: FancyButton(
        child: Text(
          "Já Assisti!",
          style: TextStyle(color: Colors.white),
        ),
        size: 18,
        color: Colors.black,
      ),
    ),
  );

  final fancybutton3 = Align(
    alignment: Alignment.bottomRight,
    child: Container(
      child: FancyButton(
        child: Text(
          "Estou Assistindo!",
          style: TextStyle(color: Colors.white),
        ),
        size: 18,
        color: Colors.black,
      ),
    ),
  );



  return Positioned(
    top: 230.0,
    child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 70.0),
        padding: EdgeInsets.all(10.0),
        width: 400,
        height: 500,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            _txtContent(doc['Descricao'], 17, FontWeight.w400),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: fancybutton,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: fancybutton2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: fancybutton3,
                  )
                ],
              ),
            ),
          ],
        )),
  );
}

//Image
Widget _img(DocumentSnapshot doc, BuildContext context) {
  String imgname = doc['Imagem'];
  return Container(
    child: ClipRRect(
      borderRadius: new BorderRadius.only(
        bottomRight: Radius.circular(2.0),
        bottomLeft: Radius.circular(85.0),
      ),
      child: Hero(
          tag: imgname,
          child: Image.network(
            imgname,
            fit: BoxFit.cover,
            height: 250,
            width: 500,
          )),
    ),
  );
}

//conteúdo do card no meio da tela
Widget _centerCardContainer(DocumentSnapshot doc) {
  final _centerCardContent = ListView(
    scrollDirection: Axis.horizontal,
    padding: EdgeInsets.all(15.0),
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _txtContent(doc['Nome'], 25.0, FontWeight.w700),
          getRow(
            _TileContent('Categoria', doc['Categoria']),
            _TileContent('Duração', doc['Duracao']),
            _TileContent('Estúdio', doc['Estudio']),
          ),
        ],
      )
    ],
  );
  return _centerCardContent;
}

//Utilitários
Text _txtContent(String type, double fontsize, FontWeight fw) {
  return Text(
    type,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: fontsize,
      fontWeight: fw,
    ),
  );
}

Container _TileContent(String title, String subtitles) {
  return Container(
    width: 75,
    height: 82,
    color: Colors.transparent,
    child: Column(
      children: <Widget>[
        _txtContent(title, 15, FontWeight.w500),
        _txtContent(subtitles, 12, FontWeight.w400),
      ],
    ),
  );
}

Row getRow(Container x, Container y, Container z) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[x, y, z],
  );
}
