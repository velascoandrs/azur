import 'package:azur/modelos/inmueble.model.dart';
import 'package:azur/pages/PublicacionActualizar.dart';
import 'package:azur/widgets/carrusel.dart';
import 'package:flutter/material.dart';

/*
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
*/

class InmuebleItem extends StatefulWidget{

  final Inmueble inmueble;
  final int idUsuario;

  InmuebleItem({this.inmueble,this.idUsuario});


  @override
  _InmuebleItemState createState() => new _InmuebleItemState();

}

class _InmuebleItemState extends State<InmuebleItem>{
  bool _activo = true;
  List<String> urls = [];

  List <String> getUrls(){
    return this.widget.inmueble.inmuebleImagenes.map((imagen)=> imagen.imagen).toList();
  }

  void _mostrarDialogo() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Aviso"),
          content: new Text("¿Desea borrar la publicación?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Si"),
              onPressed: () async{
                // Llamar al servicio de borrar
                // Desactivar widget
                setState(() {
                  _activo=false;
                });
                Navigator.pop(context);
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: ()=>Navigator.pop(context),
            )
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _activo?new Container(
      padding: const EdgeInsets.all(10),
      child: new Column(
        children: <Widget>[
          new Container(
              padding: const EdgeInsets.all(5),
              decoration: new BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight:Radius.circular(5),
              )
            ),
            child: new Stack(
              children: <Widget>[
                Carrusel(urls: getUrls(),),
              ],
            ),
          ),

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
                    title: new Text('\$'+widget.inmueble.precio.toString(), style: new TextStyle(color: Colors.white,fontSize: 20),),
                    subtitle: new Text(widget.inmueble.titulo, style: new TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                  ),
                ),
                widget.idUsuario == widget.inmueble.usuario?
                new IconButton(
                  icon: new Icon(Icons.delete),
                  tooltip: 'Eliminar publicación',
                  onPressed: (){
                    _mostrarDialogo();
                  },
                  color: Colors.redAccent,
                ):new SizedBox(),
                widget.idUsuario == widget.inmueble.usuario?
                new IconButton(
                  icon: new Icon(Icons.create),
                  tooltip: 'Actualizar publicación',
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PublicacionActualizar(inmueble: widget.inmueble,)),
                    );
                  },
                  color: Colors.blue,
                ):new SizedBox(),
                new IconButton(
                  icon: new Icon(Icons.info),
                  tooltip: 'Ver inmueble',
                  onPressed: (){
                  },
                  color: Colors.amber,
                )
              ],
            ),
          ),

        ],
      ),
    ):new Container();
  }

}

//1-1-12-2