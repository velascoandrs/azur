import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:azur/global.dart';
import 'package:azur/modelos/inmueble.model.dart';
import 'package:azur/utilitarios/session.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';


/*
Future<List<Inmueble>>obtener_publicaciones()async{
  List<Inmueble> inmuebles = new List();
  final response = await http.get(
    'http://$dominio/inmuebles/api/v1/inmuebles/?page=4',
  );
  final responseJson = json.decode(response.body)['results'];
  print(responseJson.toString());
  for (var publicacion in responseJson){
    inmuebles.add(Inmueble.fromJson(publicacion));
    print(Inmueble.fromJson(publicacion).titulo);
  }
  //return Usuario(responseJson);
  return inmuebles;
}


// Subir inmueble a la API
Future<bool>subir_publicacion(List<String> paths, ) async {
    var postUri = Uri.parse("http://$dominio/api/v1/inmuebles/post");

    var request = new http.MultipartRequest("POST", postUri);
    request.fields['user'] = 'blah';
   
   int indice = 0;
    for(String path in paths){
        request.files.add(new http.MultipartFile.fromBytes('file$indice', File(path).readAsBytesSync(), contentType: new MediaType('image', 'jpeg'),filename: "fachada"));
        indice++;
    }
    

    bool resultado = false;
     await request.send().then((response) {
        if (response.statusCode == 200){
          print("TODO OK");
            response.stream.transform(utf8.decoder).listen((value){
            print(value);
          });
          resultado = true;
        } 
      }
    );
      return resultado;
  }
  */

class InmuebleService{
  Future<bool> existePredio(String predio) async{
    final response = await http.get(
      'http://$dominio/inmuebles/api/v1/ex_predio/$predio',
    );
    if(response.statusCode==404){
      return false;
    }
    return true;
  }

  Future<dynamic> getJson(Uri uri)async{
    http.Response response = await http.get(uri);
    if(response.statusCode == 404){
      return false;
    }
    return json.decode(response.body);
  }

  Future<List<Inmueble>> recuperarInmuebles(int page){
    List<Inmueble> vacio = [];
    // Preparar la URL
    var uri = new Uri.http(dominio,"inmuebles/api/v1/inmuebles/",{
      'page':"$page",
    });
    return getJson(uri).then(
            (data){
              if(data!=false){
                print(data['results']);
                return data['results'].map<Inmueble>((item)=> new Inmueble.fromJson(item)).toList();
              }
              print("No existen mas datos!!");
              return vacio;
            }
    );
  }

  Future <bool> borrarInmueble(int idInmueble)async{
    bool resultado = true;
    String url = "http://$dominio/inmuebles/api/v2/inmuebles/$idInmueble";
    var postUri = Uri.parse(url);
    var request = new http.Request("DELETE", postUri);
    await request.send()
        .then(
            (response) {
                if (response.statusCode == 201){
                    print("Inmueble borrado");
                    resultado = true;
                }else{
                  resultado = false;
                }
        }
    );
    return resultado;
  }

  Future <bool> actualizarInmueble(
      {int idInmueble,
      String titulo,
      int predio, String ubicacion,
      double precio, int tipoInmueble,
      String descripcion, int sector,
      List<int>idsImg, List<String> rutasImg}
      )async{
    String url = "http://$dominio/inmuebles/api/v2/inmuebles/$idInmueble/";
    var postUri = Uri.parse(url);
    var request = new http.MultipartRequest("PUT", postUri);

    request.fields['predio'] = predio.toString();
    request.fields['ubicacion'] = ubicacion;
    request.fields['titulo'] = titulo;
    request.fields['precio'] = precio.toString();
    request.fields['tipo'] = tipoInmueble.toString();
    request.fields['descripcion'] = descripcion;
    request.fields['sector'] = sector.toString();
    request.fields['idsImg']=idsImg.toString();

    if(rutasImg.length > 0){
      int indice = 0;
      for(String path in rutasImg){
        request.files.add(new http.MultipartFile.fromBytes('imagen$indice', File(path).readAsBytesSync(), contentType: new MediaType('image', 'jpeg'),filename: "fto"));
        indice++;
      }
    }
    print("La peticion ${request.fields.toString()}");
    bool resultado = false;
    await request.send().then((response) {
      if (response.statusCode == 200){
        print("Inmueble actualizado");
        resultado = true;
      }
    }
    );
    return resultado;
    //var request = crearPeticion(url, "PUT");
  }
  /*
  @protected
  MultipartRequest crearPeticion(String url,String metodo, Map<String,String>parametos){
    var postUri = Uri.parse(url);
    var request = new http.MultipartRequest(metodo, postUri);
    parametos.forEach(
        (k,v){
          request.fields[k]=v;
        }
    );
    return request;
  }
 */



  Future<bool> crearInmueble(
      int predio, String ubicacion,
      List<String> rutasImg, String titulo,
      double precio, int tipoInmueble,
      String descripcion, int sector
      ) async {

      var postUri = Uri.parse("http://$dominio/inmuebles/api/v1/inmuebles/post");
      int usuario = await getUserId();
      var request = new http.MultipartRequest("POST", postUri);

      request.fields['predio'] = predio.toString();
      request.fields['ubicacion'] = ubicacion;
      request.fields['titulo'] = titulo;
      request.fields['precio'] = precio.toString();
      request.fields['tipo'] = tipoInmueble.toString();
      request.fields['descripcion'] = descripcion;
      request.fields['sector'] = sector.toString();
      request.fields['usuario'] = usuario.toString();

      print(request.fields['usuario']);
      int indice = 0;
      for(String path in rutasImg){
        request.files.add(new http.MultipartFile.fromBytes('file$indice', File(path).readAsBytesSync(), contentType: new MediaType('image', 'jpeg'),filename: "fto"));
        indice++;
      }

      bool resultado = false;
      await request.send().then((response) {
        if (response.statusCode == 201){
          print("Inmueble publicado");
          resultado = true;
        }
      }
      );
      return resultado;
  }
}


// 1 Registrar Inmueble
// 2 Subir imagenes ---> Propia clase http