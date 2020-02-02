import 'package:azur/formularios/formulario_publicacion.dart';
import 'package:flutter/material.dart';


class PublicacionCrear extends StatefulWidget {
  @override
  _PublicacionCrearState createState() => new _PublicacionCrearState();
}
class _PublicacionCrearState extends State<PublicacionCrear> {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Publicar"),
        ),
        body: new Container(
            child: new Center(
              child: new FormularioCrearPublicacion(),
            ),
        )
      );
  }
}