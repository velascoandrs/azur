import 'dart:async';

import 'package:azur/modelos/inmueble-model.dart';
import 'package:azur/modelos/inmueble.model.dart';
import 'package:azur/publicacion/publicacion-widget.dart';
import 'package:azur/servicios/publicacion.service.dart';
import 'package:azur/utilitarios/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


/*
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
}*/


class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => new _InicioState();
 }
class _InicioState extends State<Inicio> {

  bool estaCargando = false;
  ScrollController controller;
  int pagina_actual = 1;
  List<Inmueble> inmuebles = new List();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  

  @override
  void initState(){
    super.initState();
    controller = new ScrollController()..addListener(_scrollListener);
    //_All.addAll(generateWordPairs().take(20));
    _cargarDatos();
  }

  _cargarDatos()async{
    startLoader();
    var publicaciones = await InmuebleService().recuperarInmuebles(pagina_actual);

    setState((){
      print("TOTAL CARGADAS:  ${publicaciones.length}");
      if (publicaciones.length  >0 ){
        inmuebles.addAll(publicaciones);
        if(inmuebles.length>0){
          estaCargando = false;
        }
      }else{
        estaCargando = false;
      }

    });
  }


  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void _scrollListener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
        setState(() {
          pagina_actual++;
          print(pagina_actual);
        });
        

      _cargarDatos();
    }
  }

  void startLoader() {
    setState(() {
      estaCargando = !estaCargando;
      //fetchData();
    });
  }

  fetchData() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, onResponse);
  }

  void onResponse() {
    setState(() {
      estaCargando = !estaCargando;
      //_All.addAll(generateWordPairs().take(20));
    });
  }


  @override
  Widget build(BuildContext context) {
   return new Scaffold(
     appBar: new AppBar(title: Text("AZUR"),),
     body: new Stack(
       children: <Widget>[
           construirLista(),
          _cargando(),
     ],
     ),
   );
  }

  Widget construirLista(){
    return   new Container(
     margin: const EdgeInsets.all(10),
     child: new ListView.builder(
       controller: controller,
       //itemBuilder: (_,i)=>new PublicacionItem(inmueble: inmuebles[i],),
       itemBuilder: (_,i)=>new InmuebleItem(inmueble: inmuebles[i],),
       itemCount: inmuebles.length,
     ),
   );
  }

  Widget _cargando() {
    return estaCargando
        ? new Align(
            child: new Container(
              width: 140.0,
              height: 140.0,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.all(const Radius.circular(15.0)),
              ),
              child:  new Center(
                  child: new Column(
                    children: <Widget>[
                      Text(
                        "Cargando más publicaciones..",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: "VT323",fontSize: 18
                        ),
                        softWrap: true,
                      ),
                      new SizedBox(height: 20,),
                      new CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.redAccent),),
                    ],
                  )
              ),
            ),
            alignment: FractionalOffset.center,
          )
        : new SizedBox(
            width: 0.0,
            height: 0.0,
          );
  }


}
