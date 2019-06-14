import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:azur/modelos/session.dart';
import 'package:azur/modelos/usuario.model.dart';
import 'package:azur/utilitarios/session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../global.dart';




// Servicio para registrar un usuario
Future <Map> save(String email, String password, String telefono, String idNum, int tipo) async {
  var postUri = Uri.parse("http://$dominio/usuarios/crear_usuario");
  var response = await http.post(postUri,body: {'email': email, 'password': password, 'telefono':telefono, 'cedulaRuc':idNum,'tipo':tipo.toString(),});
  Map mensaje = json.decode(response.body)['mensaje'];
  if(response.statusCode == 201){
      mensaje['estado'] = true;
  }else{
      mensaje['estado'] = false;
      List<String> errores = []; 
      for (var m in mensaje.keys){
        errores.add(mensaje[m].toString().substring(1,mensaje[m].toString().length-2));
      }
      mensaje['errores-list'] = errores;

  }
  print(mensaje);
  
  return mensaje;
}

Future <bool> validar(String codigo) async {
  var postUri = Uri.parse("http://$dominio/usuarios/activar/$codigo");
  var response = await http.post(postUri,);
  
    if(response.statusCode == 201){
      return true;
  }
  return false;
}


// Servicio de login, retorna el Token y el Token de refrescamiento
Future <bool> login(String email, String password) async {
    var postUri = Uri.parse("http://$dominio/api/token/");
    var response = await http.post(postUri, body: {'email': email, 'password': password});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if(response.statusCode==401){
      print("Login invalido");
      return false;
    }
    String token = json.decode(response.body)['access'];
    String refresToken = json.decode(response.body)['refresh'];
    Usuario usuario = await obtenerDatosUsuario(token);
    Session session = new Session(token: token, refreshToken: refresToken, usuario: usuario);
    guardarSession(session);
    return true;
}



// Obtener los datos del usuario a traves del token de autirzacion
Future <Usuario> obtenerDatosUsuario(String token)async{
    final response = await http.get(
    'http://$dominio/api/usuario/get',
    headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
  );
  final responseJson = json.decode(response.body);
  print(responseJson.toString());
  return Usuario(responseJson);
}

Future<bool> existeCorreo(String correo) async{
  final response = await http.get(
    'http://$dominio/usuarios/api/v1/ex_correo/$correo',
  );
  if(response.statusCode==404){
    return false;
  }
  return true;
}


// Refrescar la session del usuario
refrescarToken(String refreshToken) async{
    var postUri = Uri.parse("http://$dominio/api/token/refresh/");
    var response = await http.post(postUri, body: {'refresh': refreshToken});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    String token = json.decode(response.body)['access'];
    String refresToken = json.decode(response.body)['refresh'];
    Usuario usuario = await obtenerDatosUsuario(token);
    Session session = new Session(token: token, refreshToken: refresToken, usuario: usuario);
    guardarSession(session);
}


  
