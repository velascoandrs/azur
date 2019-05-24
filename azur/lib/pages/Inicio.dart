import 'package:azur/modelos/inmueble-model.dart';
import 'package:azur/publicacion/publicacion-widget.dart';
import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
  return new Scaffold(
   appBar: new AppBar(
     title: new Text("AZUR"),
   ), 
   body: 
   new Container(

     margin: const EdgeInsets.all(10),
     child: new ListView.builder(
       itemBuilder: (_,i)=>new PublicacionItem(publicacionModel: publicaciones[i],),
       itemCount: publicaciones.length,
     ),
   ),
 );
 }
}