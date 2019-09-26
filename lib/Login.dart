import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            autofocus: true,
            keyboardType: TextInputType.text,
            style: new TextStyle(color: Colors.white, fontSize: 20),
            decoration: InputDecoration(
              labelText: "Login: ",
              labelStyle: TextStyle(color: Colors.orange),
            ),
          ),
          Divider(),
          TextFormField(
            autofocus: true,
            obscureText: true,
            keyboardType: TextInputType.text,
            style: new TextStyle(color: Colors.white, fontSize: 20),
            decoration: InputDecoration(
              labelText: "Senha:",
              labelStyle: TextStyle(color: Colors.orange),
            ),
          ),
          Divider(),
          ButtonTheme(
            height: 60.0,
            child: RaisedButton(
              onPressed: () => {},
              child: Text(
                "Entrar",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.orange,
            ),
          )
        ],
      ),
    );
  }
}
