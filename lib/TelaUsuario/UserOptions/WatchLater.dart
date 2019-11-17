import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/DAO/UsuarioDAO.dart';
import 'package:flutter_app/TelaUsuario/Perfil.dart';

class WatchLater extends StatefulWidget {
  @override
  _WatchLaterState createState() => _WatchLaterState();
}

class _WatchLaterState extends State<WatchLater> {
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

    final _animWatchLater = StreamBuilder(
        stream: Firestore.instance
            .collection('User')
            .document('$email')
            .collection('AssistirMaisTarde')
            .snapshots(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          //Se não tiver nenhum carregando, adicione o "Carregando"
          if (!snapshot.hasData) return _onLoading;
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext ctx, int index) {
              DocumentSnapshot doc = snapshot.data.documents[index];
              return ListTile(
                leading: Icon(
                  Icons.watch_later,
                  size: 50,
                  color: Colors.white,
                ),
                title: Text(
                  doc['Nome'],
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  doc['Categoria'],
                  style: TextStyle(color: Colors.white),
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
              body: Center(child: _animWatchLater),
            ),
            new Perfil(),
          ],
        ),
      ),
    );
  }
}
