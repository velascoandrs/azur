import 'package:azur/pages/Busqueda.dart';
import 'package:azur/pages/Inicio.dart';
import 'package:azur/pages/PublicacionCrear.dart';
import 'package:azur/utilitarios/session.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {

  String usuario;
  Home({this.usuario});

  @override
  _HomeState createState() => new _HomeState();
 }
class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

   Drawer _getDrawer(BuildContext context){

      var header = new DrawerHeader(child: new Text("Bienvenido: ${widget.usuario}"),);
      var info = new AboutListTile(
        child: new Text("Informacion App"),
        applicationIcon: new Icon(Icons.location_searching),
        icon: new Icon(Icons.info),
        applicationVersion: "v0.0.1",
        applicationName: "PimbaSoft",
        );


      ListTile _getItem(Icon icon, String descripcion, String ruta){
        return new ListTile(
          leading: icon,
          title: new Text(descripcion),
          onTap: (){
            setState(() {
              Navigator.of(context).pushNamed(ruta);
          });
        },
      );
    }

      ListTile _cerrarSession(Icon icon){
        return new ListTile(
          leading: icon,
          title: new Text("Cerrar Sesion"),
          onTap: (){
            cerrarSession();
            setState(() {
              Navigator.of(context).pushNamed("/");
            });
          },
        );
      }

    //cerrarSession
    ListView _listView = new ListView(children: <Widget>[
      header,
      info,
      //_getItem(new Icon(Icons.people),widget.usuario , ''),
      _getItem(new Icon(Icons.person), "Perfil", "/configuracion"),
      _cerrarSession(new Icon(Icons.exit_to_app)),
      _getItem(new Icon(Icons.add_circle_outline), "Publicar Inmueble", "/publicar_inmueble")

    ],);

    return new Drawer(
      child: _listView,
    );
}

  TabController controladorTap;

  @override
  void initState(){
    super.initState();
    controladorTap = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
   return new Container(
     child: new Scaffold(
       appBar: new AppBar(
         title: new Text("AZUR"),
       ),
       drawer: new Drawer(
         child: _getDrawer(context),
       ),
       bottomNavigationBar: new Material(
         color: Colors.black12,
         child: new TabBar(
           controller: controladorTap,
           tabs: <Widget>[
             new Tab(
               icon: new Icon(Icons.home),
             ),
             new Tab(
               icon: new Icon(Icons.search),
             ),
           ],

         ),
       ),
       body: new TabBarView(
         controller: controladorTap,
         children: <Widget>[
           new Inicio(),
           new Busqueda(),
         ],
       ),
     ),
   );
  }
}