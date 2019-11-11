import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

//Esse método não está separado na DAO
Widget gridViewFromFirebase(BuildContext context) {
  final content = StreamBuilder(
      //Coleção
      stream: Firestore.instance.collection('Animes').snapshots(),

      /// <--------- FIREBASE
      //build
      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
        //Se não tiver nenhum, carregando.
        if (!snapshot.hasData)
          return Container(
            width: 100,
            height: 50,
            alignment: Alignment.center,
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                  Radius.circular(5.0) //         <--- border radius here
                  ),
            ),
            child: Text("Carregando .... "),
          );
        //Retorna a gridViewTOP
        return GridView.builder(
            itemCount: snapshot.data.documents.length,
            primary: false,
            padding: const EdgeInsets.all(6),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 8,
                childAspectRatio: 3 / 5.2),
            itemBuilder: (BuildContext ctx, int index) {
              DocumentSnapshot doc = snapshot.data.documents[index];

              /// <--------- FIREBASE
              return _cardUtilFirebase(doc, context);
            });
      });
  return content;
}

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
    )
  );



  final stackFundo = Stack(
    alignment: Alignment.bottomCenter,
    children: <Widget>[
      ClipRRect(
        borderRadius: new BorderRadius.circular(9.0),
        child: Image.network(
          doc['Imagem'],/// <--------- FIREBASE
          fit: BoxFit.cover,
          width: 150,
          height: 130.5,
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
          Navigator.pushNamed(context, '/Details', arguments: doc); /// <--------- FIREBASE
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
