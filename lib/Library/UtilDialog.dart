import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/DAO/UsuarioDAO.dart';

class Dialogs {
  //Dialog exibido quando o cara clica em "Estou assistindo"
  dialogAssistindo(BuildContext context, DocumentSnapshot doc) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController _temp = new TextEditingController();
    TextEditingController _ep = new TextEditingController();
    final GlobalKey<FormState> _formkeyAssistindo = GlobalKey<FormState>();
    double dialogheigth = height / 2;
    void _add() {
      if (_formkeyAssistindo.currentState.validate()) {
        _formkeyAssistindo.currentState.save();
        FirebaseLoginSet().addToAssistindo(doc, _temp.text, _ep.text);
        _temp.clear();
        _ep.clear();
      }
    }

    //TextFormFiel1 da Temporada
    final _textTemporada = Padding(
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        controller: _temp,
        onSaved: (value) {
          Navigator.of(context).pop();
        },
        validator: (value) {
          if (_temp.text == "" && _ep.text == "") {
            return "Digite ao menos um valor";
          }
        },
        decoration: InputDecoration(
          labelText: 'Digite a Temporada',
          labelStyle: TextStyle(color: Colors.black),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
          ),
          border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(color: Colors.teal)),
        ),
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black),
        cursorColor: Colors.black,
      ),
    );

    //TextFormFiel2 do Episódio
    final _txtEpisodio = Padding(
        padding: EdgeInsets.all(10.0),
        child: Theme(
          data: new ThemeData(
            hintColor: Colors.white,
          ),
          child: TextFormField(
            controller: _ep,
            validator: (value) {
              if (_temp.text == "" && _ep.text == "") {
                return "Digite ao menos um valor";
              }
            },
            decoration: InputDecoration(
              labelText: 'Digite o Episódio',
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: UnderlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: BorderSide(color: Colors.orange),
              ),
              border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(color: Colors.teal)),
            ),
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black),
            cursorColor: Colors.black,
          ),
        ));

//Botão de enviar
    final _btnSubmit = FlatButton(
      onPressed: () {
        _add();
      },
      child: Text('Adicionar'),
    );

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              height: dialogheigth,
              width: double.infinity,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Form(
                      key: _formkeyAssistindo,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Digite a ultima Temporada ou o ultimo Episódio assistido',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.orangeAccent[400]),
                          ),
                          _textTemporada,
                          _txtEpisodio,
                          _btnSubmit
                        ],
                      ),
                    ),
                  )),
            ),
          );
        });
  }

  dialogSucess(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double dialogheigth = height / 2.5;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              height: dialogheigth,
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Anime adicionado com sucesso! ',
                      style: TextStyle(color: Colors.green),
                    ),
                    Icon(
                      Icons.done,
                      color: Colors.green,
                      size: 200,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  dialogFailedAlreadyAdded(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double dialogheigth = height / 2.5;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              height: dialogheigth,
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Esse anime já está adicionado!',
                      style: TextStyle(color: Colors.red),
                    ),
                    Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 100,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
