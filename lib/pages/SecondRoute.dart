import 'package:flutter/material.dart';
import '../Util/Factory.dart';

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
          leading: Icon(Icons.list),
          backgroundColor: Colors.orangeAccent,
          title: Center(
            child: Text("Otaku Library"),
          )),
      body: gridViewFromFirebase(),
    );
  }
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
