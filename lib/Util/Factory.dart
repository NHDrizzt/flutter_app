import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Card cardFactory(String img, String nome) {
  return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            height: 60,
            width: 90,
            child: Image.asset('$img', fit: BoxFit.fill),
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(
                color: Colors.white70,
                blurRadius: 10.0,
              ),
            ]),
          ),
          ListTile(
            title: Text(
              "$nome",
              style: TextStyle(fontSize: 13),
            ),
          ),
          IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: null)
        ],
      ));
}

Widget gridViewFromFirebase() {
  final content = StreamBuilder(
    //Coleção
      stream: Firestore.instance.collection('Animes').snapshots(),
      //build
      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
        //Se não tiver nenhum, carregando.
        if (!snapshot.hasData) return const Text('Carregando....');
        //Retorna a gridViewTOP
        return GridView.builder(
            itemCount: snapshot.data.documents.length,
            primary: false,
            padding: const EdgeInsets.all(6),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 7,
              mainAxisSpacing: 8,
              childAspectRatio: 80 / 130,
            ),
            itemBuilder: (BuildContext ctx, int index) {
              DocumentSnapshot doc = snapshot.data.documents[index];
              return _cardUtilFirebase(doc);
            });
      });
  return content;
}

Card _cardUtilFirebase(DocumentSnapshot doc) {
  return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            height: 60,
            width: 90,
            child: Image.network(doc['Imagem'],),
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(
                color: Colors.white70,
                blurRadius: 10.0,
              ),
            ]),
          ),
          ListTile(
            title: Text(
              doc['Nome'],
              style: TextStyle(fontSize: 13),
            ),
          ),
          IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: null)
        ],
      ));
}
