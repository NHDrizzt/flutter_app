import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

//Esse método não está separado na DAO
Widget gridViewFromFirebase(BuildContext context, width, heigth) {
  final _onLoading = Container(
      width: width,
      height: heigth,
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

  final content = StreamBuilder(
      //Estou dizendo para o Firebase, "Abra um fluxo disso aqui" no caso, da coleção 'Animes'
      stream: Firestore.instance.collection('Animes').snapshots(),
      //Sempre que você usa um StreamBuilder, ele usa essa stream para "ver" o que está acontencendo nesse 'fluxo'
      //Se adicionar alguma coisa no Firebase, ele atualiza automaticamente por causa da stream

      //Construtor
      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
        //Se não tiver nenhum carregando, adicione o "Carregando"
        if (!snapshot.hasData) return _onLoading;
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
