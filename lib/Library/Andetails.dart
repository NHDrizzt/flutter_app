import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/DAO/UsuarioDAO.dart';
import 'package:flutter_app/Library/UtilDialog.dart';
import 'package:flutter_app/Library/globals.dart' as globals;
import 'package:flutter_app/pages/Library/fancy.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class detailsAnime extends StatefulWidget {
  @override
  _detailAn createState() => _detailAn();
}

double widthScreen;
double heightScreen;

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
          onPressed: () {})
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
    widthScreen = MediaQuery.of(context).size.width;
    heightScreen = MediaQuery.of(context).size.height;
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

//Responsável pelo botão animado á direita da tela
    final _speedDial = SpeedDial(
      backgroundColor: Colors.black,
      animatedIcon: AnimatedIcons.add_event,
      children: [
        //Botão de "Estou assistindo" com o ícone de Alarme +
        SpeedDialChild(
            child: Icon(Icons.alarm_add),
            label: 'Estou assistindo!',
            backgroundColor: Colors.orangeAccent[400],
            onTap: () {
              Dialogs().dialogAssistindo(context, doc);
            }),

        //Botão "Quero assistir" com ícone WatchLater
        SpeedDialChild(
            child: Icon(Icons.watch_later),
            label: 'Quero Assistir',
            backgroundColor: Colors.orangeAccent[400],
            onTap: () {
              //Adiciona aos "Quero Assistir" pela DAO
              FirebaseLoginSet().addToWatchLater(doc);
              //Exibe o Dialog de sucess
              Dialogs().dialogSucess(context);
              //Dá um pop no dialog pós 3 segundos
              Future.delayed(Duration(seconds: 3), () {
                Navigator.of(context).pop();
              });
            }),

        //Botão "Já assisti, com ícone de Done"
        SpeedDialChild(
            child: Icon(Icons.done),
            label: 'Já Assisti!',
            backgroundColor: Colors.orangeAccent[400],
            onTap: () {
              //Adiciona aos Assistidos pela DAO
              FirebaseLoginSet().addToAssistidos(doc);
              Dialogs().dialogSucess(context);
              Future.delayed(Duration(seconds: 3), () {
                Navigator.of(context).pop();
              });
            }),

        //Botão para favoritar com ícone estrela
        SpeedDialChild(
            child: Icon(Icons.star),
            label: 'Favoritar',
            backgroundColor: Colors.orangeAccent[400],
            onTap: () {
              //Adiciona aos favoritos pela DAO
              FirebaseLoginSet().addToFavorites(doc);
              Dialogs().dialogSucess(context);
              Future.delayed(Duration(seconds: 3), () {
                Navigator.of(context).pop();
              });
            }),
      ],
    );

    if (globals.isLoggedIn == true) {
      return Scaffold(
        floatingActionButton: _speedDial,
        body: Stack(
          children: <Widget>[
            _img(doc, context),
            // _getGradient,
            _descAnime(doc),
            _posAppbar,
            _centerCard
          ],
        ),
        backgroundColor: Colors.orangeAccent[200],
      );
    } else if (globals.isLoggedIn == false) {
      return Scaffold(
        //    body: _body(doc, context),
        body: Stack(
          children: <Widget>[
            _img(doc, context),
            // _getGradient,

            _descAnime2(doc),
            _posAppbar,
            _centerCard,
          ],
        ),
        backgroundColor: Colors.orange,
      );
    }
  }

  //Descrição do Anime
  Widget _descAnime(DocumentSnapshot doc) {
    return Positioned(
      top: 230.0,
      child: new Container(
          margin: new EdgeInsets.symmetric(vertical: 40.0),
          padding: EdgeInsets.all(12.0),
          width: widthScreen,
          height: 500,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              _txtContent(doc['Descricao'], 17, FontWeight.w400),
            ],
          )),
    );
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
                      child: new Text(
                          "Você precisa estar LOGADO para adicionar Animes"),
                      color: Colors.red,
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
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
