class Imagen{
  String imagen;
  int id;
  Imagen({this.imagen,this.id});
  factory Imagen.fromJson(Map<String, dynamic> parsedJson){
    return Imagen(
        imagen:parsedJson['imagen'],
        id:parsedJson["id"],
    );
  }
}



class Inmueble{
  String ubicacion;
  String titulo;
  int tipo;
  int usuario;
  int sector;
  //int predio;
  double precio;
  int id;
  String descripcion;
  List<Imagen> inmuebleImagenes;
  Inmueble({this.titulo,this.precio,this.ubicacion,this.id=0,this.inmuebleImagenes,this.tipo,this.usuario,this.sector,this.descripcion});
    // Deserializar el inmueble desde el json
  factory Inmueble.fromJson(Map<String, dynamic> json){
      var listaImg = json['inmuebleImagenes'] as List;
      return Inmueble(id: json["predio"],
          precio: double.parse(json["precio"]),
          //predio = json["predio"],
          usuario: json["usuario"],
          tipo: json["tipo"],
          titulo: json["titulo"],
          ubicacion:json["ubicacion"],
          sector: json["sector"],
          descripcion: json["descripcion"],
          inmuebleImagenes: listaImg.map((v)=>new Imagen(imagen: v['imagen'],id: v["id"])).toList()
      );
    }
}