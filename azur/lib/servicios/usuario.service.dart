import 'dart:convert';
import 'dart:io';
import 'package:azur/modelos/usuario.model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../global.dart';



Future <bool> save(String email, String password, String telefono, String idNum, int tipo) async {
  var postUri = Uri.parse("http://$dominio/api/token/");
  var response = await http.post(postUri,
     body: {
       'email': email, 
       'password': password, 
       'telefono':telefono, 
       'cedulaRuc':idNum,
       'tipo':tipo,
       }
      );
  return json.decode(response.body)['estado'];
}


// Servicio de login, retorna el Token y el Token de refrescamiento
Future <Usuario> login(String email, String password) async {
    var postUri = Uri.parse("http://$dominio/api/token/");
    var response = await http.post(postUri, body: {'email': email, 'password': password});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return await obtenerDatosUsuario(json.decode(response.body)['access']);
}


Future <Usuario> obtenerDatosUsuario(String token)async{
    final response = await http.get(
    'http://$dominio/api/usuario/get',
    headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
  );
  final responseJson = json.decode(response.body);
  print(responseJson.toString());
  return Usuario(responseJson);
}

  
