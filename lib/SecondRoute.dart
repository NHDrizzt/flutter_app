import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          leading: Icon(Icons.list),
          backgroundColor: Colors.orangeAccent,
          title: Center(child: Text("Otaku Library"),)
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(6),
          crossAxisSpacing: 7,
          mainAxisSpacing: 8,
          crossAxisCount: 3,
          childAspectRatio: 84/130,
          children: <Widget>[
            _CardFactory('images/GridViewImgs/img2.jpg', "Dragon Ball"),
            _CardFactory('images/GridViewImgs/img3.jpg', "Cowboy Bebop"),
            _CardFactory('images/GridViewImgs/img4.jpg', "Cowboy Bebop filme"),
            _CardFactory('images/GridViewImgs/img5.jpg', "Full Metal Alchemist"),
            _CardFactory('images/GridViewImgs/img6.jpg', "Hellsing"),
            _CardFactory('images/GridViewImgs/img7.jpg', "Shigatsu"),
            _CardFactory('images/GridViewImgs/img8.jpg', "Naruto"),
            _CardFactory('images/GridViewImgs/img9.jpg', "One Piece"),
            _CardFactory('images/GridViewImgs/img10.jpg', "Pokémon"),
            _CardFactory('images/GridViewImgs/img11.jpg', "Pokémon filme"),
            _CardFactory('images/GridViewImgs/img12.jpg', "Bakemonogatari"),
            _CardFactory('images/GridViewImgs/img13.jpg', "Watamote"),

          ],
        ));
  }
}

Card _CardFactory(String img, String nome) {
  return  Card(
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
            child: Image.asset('$img',
              fit: BoxFit.fill
            ),
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(
                color: Colors.white70,
                blurRadius: 10.0,
              ),
            ]),
          ),
        ListTile(
          title: Text("$nome", style: TextStyle(fontSize: 13),),
        ),
          IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: null)
        ],
      )
    );
}

TextFormField _TextFactory(String text, TextEditingController keppo) {
  return TextFormField(
    controller: keppo,
    decoration: new InputDecoration(
      hintText: "$text",
      fillColor: Colors.white,
      border: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(25.0),
        borderSide: new BorderSide(),
      ), //fillColor: Colors.green
    ),
  );
}
