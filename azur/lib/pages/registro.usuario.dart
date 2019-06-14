import 'package:azur/formularios/formulario_registro.dart';
import 'package:flutter/material.dart';

class Registro extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
  return new Scaffold(
    appBar: new AppBar(
      title: new Text("Registro de usuario"),
    ),
    body: new Container(
      child: new Center(
          child: new FormularioRegistro(),
      )
    ),
 );
 }
}