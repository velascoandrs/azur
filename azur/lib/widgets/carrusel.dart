import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';


class Carrusel extends StatefulWidget{

  final List<String> urls;
  Carrusel({this.urls});


  @override
  _CarruselState createState() => new _CarruselState();

}

class _CarruselState extends State<Carrusel> {
  int _indiceActual =0;

  @override
  Widget build(BuildContext context) {
    return  new Container(
      child: new Stack(
        children: <Widget>[
          _construirVisor(),
          _construirIndice(),
        ],
      ),
    );

  }

  Widget _construirIndice(){
    return Positioned(
      top: 10,
      left: 10,
      child: IndiceImagenes( indice: this._indiceActual, numeroPuntos: this.widget.urls.length-1,),
    );
  }
  Widget _construirVisor(){
    return new Container(
      height: 200,
      child: new PageView.builder(
        onPageChanged: (int page){
              setState(() {
                  this._indiceActual = page;
                  print("Indice de foto: $_indiceActual");
              });
          },
        scrollDirection: Axis.horizontal,
        itemCount: widget.urls.length,
        itemBuilder: (BuildContext context, int index){
          return new Container(
            width: 200,
            child: new CachedNetworkImage(
              fadeInDuration: Duration(milliseconds: 7),
              fadeOutDuration: Duration(milliseconds: 7),
              placeholder: (context, url) {
                return new Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  child: new CircularProgressIndicator(),
                );
              },
              errorWidget: (context, url, error) => new Icon(Icons.error),
              imageUrl: widget.urls[index],
              fit: BoxFit.cover,
              height: 200.0,
              width: double.infinity,
            ),
          );
        },
      ),
    );
  }

}

class IndiceImagenes extends StatelessWidget{
  final int numeroPuntos;
  final int indice;
  IndiceImagenes({this.numeroPuntos, this.indice});

  Widget _inactivePhoto() {
    return new Container(
        child: new Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: Container(
            height: 8.0,
            width: 8.0,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4.0)
            ),
          ),
        )
    );
  }

  Widget _activePhoto() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
          height: 10.0,
          width: 10.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0.0,
                    blurRadius: 2.0
                )
              ]
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];

    for(int i = 0; i<= numeroPuntos; ++i) {
      dots.add(
          i == indice ? _activePhoto(): _inactivePhoto()
      );
    }

    return dots;
  }


  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(),
      ),
    );
  }

}