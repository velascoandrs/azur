import 'package:azur/modelos/inmueble.model.dart';
import 'package:azur/widgets/widgets_img_lib.dart';
import 'package:flutter/material.dart';

class PublicacionItem extends StatelessWidget {
  final Inmueble inmueble;
  PublicacionItem({this.inmueble});

  List <String> getUrls(){
    return this.inmueble.inmuebleImagenes.map((imagen)=> imagen.imagen).toList();
  }

 @override
 Widget build(BuildContext context) {
  return  new Column(
      children: <Widget>[
        //new Carusel(urls: publicacionModel.portadaUrl,),
        new Divider(
          height: 20,
        ),
        new ImageCarousel(urls: getUrls()),
         new Container(
           padding: const EdgeInsets.all(5),
          decoration: new BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5),
              bottomRight:Radius.circular(5),
            )
          ),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new ListTile(
                  title: new Text('\$'+inmueble.precio.toString(), style: new TextStyle(color: Colors.white,fontSize: 20),),
                  subtitle: new Text(inmueble.titulo, style: new TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                ),
              ),
              new RaisedButton(
                child: new Text("Información",style: new TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                onPressed: (){},
                color: Colors.redAccent,
              )
            ],
            ) 
         ), 
          ], 
 );
 }
}


//1-1-12-2