import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/DAO/UsuarioDAO.dart';
import 'package:flutter_app/TelaUsuario/Perfil.dart';

class Assistindo extends StatefulWidget {
  Assistindo({Key key}) : super(key: key);

  @override
  _AssistindoState createState() => _AssistindoState();
}

class _AssistindoState extends State<Assistindo> {
  String email;
//Colocar o email para eu poder fazer a consulta no banco
  Future<void> _getCurrentUser() async {
    await FirebaseLoginSet().currentUser().then((value) {
      setState(() {
        email = value;
      });
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Tamanho da tela
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    _getCurrentUser();

    final _onLoading = Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(5.0) //         <--- border radius here
              ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Carregando .... "),
              CircularProgressIndicator()
            ],
          ),
        ));

    final _animAssistindo = StreamBuilder(
        stream: Firestore.instance
            .collection('User')
            .document('$email')
            .collection('SendoAssistido')
            .snapshots(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          //Se não tiver nenhum carregando, adicione o "Carregando"
          if (!snapshot.hasData) return _onLoading;
          //
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext ctx, int index) {
              DocumentSnapshot doc = snapshot.data.documents[index];
              return Container(
                padding: EdgeInsets.all(15),
                width: width,
                height: height / 9,
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.orange[400],
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    border: Border.all(
                      color: Colors.black,
                      width: 10.0,
                    )),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          doc['Nome'],
                          style: TextStyle(color: Colors.black, fontSize: 22),
                        ),
                      ],
                    ),
                    _columnAux("Temporada ", doc['UltimaTemp'], 12),
                    _columnAux("Episódio ", doc['UltimoEp'], 12)
                  ],
                ),
              );
            },
          );
        });

    return SafeArea(
      top: false,
      bottom: false,
      child: new Container(
        child: new Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
              ),
              backgroundColor: Colors.black,
              body: _animAssistindo,
            ),
            new Perfil(),
          ],
        ),
      ),
    );
  }

  Widget _columnAux(String txt1, String txt2, double fontsize) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(txt1, style: TextStyle(color: Colors.black, fontSize: fontsize)),
          Spacer(),
          Text(
            txt2,
            style: TextStyle(color: Colors.black, fontSize: fontsize),
          ),
        ],
      ),
    );
  }
}
