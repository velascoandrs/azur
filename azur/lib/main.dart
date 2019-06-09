import 'package:azur/formularios/formulario_login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    theme: new ThemeData(
        brightness: Brightness.dark,                        // new
    ),
   home: AzurApp(),
  ));
}


class AzurApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {

  return Container(
    child: Scaffold(
      appBar: new AppBar(title: new Text("Login"),),
      body: new Container(
        margin: const EdgeInsets.only(
          left: 30,
          right: 30
        ),
        child: new Center(
          child: new FormularioLogin(),
        ),
      )
    ),
    
 );
 }
}