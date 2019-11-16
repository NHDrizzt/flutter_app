import 'package:flutter/material.dart';

class Dialogs {
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
