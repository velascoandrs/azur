import 'package:azur/formularios/formulario_actualizar_publicacion.dart';
import 'package:azur/modelos/inmueble.model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PublicacionActualizar extends StatefulWidget {
  Inmueble inmueble;

  PublicacionActualizar({this.inmueble});

  @override
  _PublicacionActualizarState createState() => new _PublicacionActualizarState();
}
class _PublicacionActualizarState extends State<PublicacionActualizar> {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Actualizar Publicación"),
        ),
        body: new Container(
          child: new Center(
            child: new FormularioActualizarPublicacion(inmueble: widget.inmueble,),
          ),
        )
    );
  }
}