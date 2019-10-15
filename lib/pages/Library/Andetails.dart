import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/DAO/AnimeDAO.dart';

class detailsAnime extends StatefulWidget {
  @override
  _detailAn createState() => _detailAn();
}

class _detailAn extends State<detailsAnime> {
  @override
  Widget build(BuildContext context) {
    DocumentSnapshot doc = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: _body(doc, context),
      backgroundColor: Colors.orange,
    );
  }
}

Stack _body(DocumentSnapshot doc, BuildContext context) {
  String imgname = doc['Imagem'];
  //ImageController
  final _img = Container(
    child: ClipRRect(
      borderRadius: new BorderRadius.only(
        bottomRight: Radius.circular(0.0),
        bottomLeft: Radius.circular(0.0),
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

  //Descrição do Anime
  final _descAnime =
  Positioned(
    top: 300.0,
    child: new Container(
      margin: new EdgeInsets.symmetric(vertical: 45.0),
      padding: EdgeInsets.all(15.0),
      width: 350,
      height: 500,
      decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.all(
            Radius.circular(0.0),
          )),
      child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _txtContent(doc['Descricao'], 16, FontWeight.w300)
            ],
          ),
    ),
  );

  //Transição de cores
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

  return Stack(
    children: <Widget>[
      _img,
      _getGradient,
      _posAppbar,
      _descAnime,
      _centerCardContainer(doc),
    ],
  );
}

Row getRow(Container x, Container y, Container z) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[x, y,z],
  );
}

//conteúdo do card no meio da tela
Widget _centerCardContainer(DocumentSnapshot doc) {
  final _centerCardContent = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      _txtContent(doc['Nome'], 25.0, FontWeight.w700),
      getRow(
        _TileContent('Categoria', doc['Categoria']),
        _TileContent('Duração', doc['Duracao']),
        _TileContent('Estúdio', doc['Estudio']),
      ),
    ],
  );

//Card no meio da Tela
  final _centerCard = Positioned(
    top: 165.0,
    child: new Container(
      margin: new EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.all(20.0),
      height: 180.0,
      width: 300.0,
      child: _centerCardContent,
      decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          )),
    ),
  );
  return _centerCard;
}

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
