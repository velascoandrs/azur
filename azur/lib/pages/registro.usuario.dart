import 'dart:async';

import 'package:azur/formularios/formulario_registro.dart';
import 'package:azur/servicios/usuario.service.dart';
import 'package:flutter/material.dart';
/*
class Registro extends StatelessWidget {

  var top = FractionalOffset.topCenter;
  var bottom = FractionalOffset.bottomCenter;

  var list = [
    Colors.black12,
    Colors.amberAccent,
  ];

  String _now;
  Timer _everySecond;



 @override
 Widget build(BuildContext context) {
  return new Scaffold(
    appBar: new AppBar(
      title: new Text("Registro de usuario"),
    ),
    body: new AnimatedContainer(
      decoration: BoxDecoration(
        gradient: new LinearGradient(
          begin: top,
          end: bottom,
          colors: list,
          stops: [0.0,1.0]
        )
      ),
      duration: Duration(seconds: 1),
      child: new Center(
          child: new FormularioRegistro(),
      )
    ),
 );
 }
}
*/

class Registro extends StatefulWidget{
  RegistroState createState() => RegistroState();
}

class RegistroState extends State<Registro> {

  var top = FractionalOffset.topCenter;
  var bottom = FractionalOffset.bottomCenter;

  var list = [
    Colors.black12,
    Colors.amberAccent,
  ];



    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Registro de usuario"),
        ),
        body: new Container(
            decoration: BoxDecoration(
                gradient: new LinearGradient(
                    begin: top,
                    end: bottom,
                    colors: list,
                    stops: [0.4, 1.0]
                )
            ),
            child: new Center(
              child: new FormularioRegistro(),
            )
        ),
      );
    }

}
