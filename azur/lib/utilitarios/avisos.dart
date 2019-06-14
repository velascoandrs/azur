import 'package:flutter/material.dart';

class Avisos extends StatelessWidget {
  List<String> mensajes;
  Avisos({this.mensajes});

  Widget _construirAviso(List<String> contenido){

      String texto='';
      for(int i=0; i < contenido.length-1 ; i++){
        texto += '*'+contenido[i] +'\n';
      }

      return Container(child: Text(texto, style: TextStyle(color: Colors.white, fontSize: 15),), padding: const EdgeInsets.all(5)); 
  }

 @override
 Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        color: new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
         boxShadow: <BoxShadow>[
          new BoxShadow(  
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
        
      ),
      child:_construirAviso(this.mensajes),
  
    );
 }
}