import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/DAO/UsuarioDAO.dart';
import 'package:flutter/material.dart';

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
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

    final _animFavoritos = StreamBuilder(
        stream: Firestore.instance
            .collection('User')
            .document('$email')
            .collection('AnimesFavoritos')
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
                  Icons.star,
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: _animFavoritos,
      ),
    );
  }
}

//Não to usando
Hero _cardUtilFirebase(DocumentSnapshot doc, BuildContext context) {
  final descanime = Container(
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.all(
            Radius.circular(5.0) //         <--- border radius here
            ),
      ),
      child: Column(
        children: <Widget>[
          Text(
            doc['Nome'],

            /// <--------- FIREBASE
            style: TextStyle(
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ));

  final stackFundo = Stack(
    alignment: Alignment.bottomCenter,
    children: <Widget>[
      ClipRRect(
        borderRadius: new BorderRadius.circular(9.0),
        child: Image.network(
          doc['Imagem'],
          fit: BoxFit.cover,
          width: 150,
          height: 132,
        ),
      ),
      descanime,
    ],
  );

  String _imgname = doc['Imagem'];
  return Hero(
      tag: _imgname,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/Details', arguments: doc);
        },
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                stackFundo,
              ],
            )),
      ));
}
