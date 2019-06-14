import 'package:azur/modelos/usuario.model.dart';

class Session{

  String token = '';
  String refreshToken = '';
  Usuario usuario;
  
  Session({this.token,this.refreshToken,this.usuario});

}