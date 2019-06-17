import 'package:azur/formularios/formulario_login.dart';
import 'package:azur/pages/PublicacionCrear.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    routes: <String, WidgetBuilder>{
      '/publicar_inmueble':(BuildContext context)=> new PublicacionCrear(),

    },
    theme: new ThemeData(
        brightness: Brightness.dark,
        hintColor: Colors.amber,
        highlightColor: Colors.amber,
        // Define the default Font Family
        fontFamily: 'Montserrat',
        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
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
        decoration:  new BoxDecoration(
          image: new DecorationImage(
            image: new NetworkImage('https://images5.alphacoders.com/365/thumb-1920-365738.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: new Container(
          margin: const EdgeInsets.only(
          left: 30,
          right: 30
        ),
          child: new Center(
            child: new FormularioLogin(),
          )
        ),
      )
    ),
    
 );
 }
}