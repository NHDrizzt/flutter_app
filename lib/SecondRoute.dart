
import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Otaku Library'),
      ),
      body: new Center(
        child: Container(
          child: ListView(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TextFormField _TextFactory(String text, TextEditingController keppo)  {
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
