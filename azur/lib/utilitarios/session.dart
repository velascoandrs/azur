import 'package:azur/modelos/session.dart';
import 'package:shared_preferences/shared_preferences.dart';



// Guardar los datos de la session del usuario
guardarSession(Session session)async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token',session.token);
      prefs.setString('retoken',session.refreshToken);
      prefs.setString('usuario_id',session.usuario.id);
      prefs.setString('usuario_ced', session.usuario.cedulaRuc);
}




// Obtener el id del usuario
Future<String> getUserId()async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('usuario_id') ?? '';
}


// Obtner el numero de ced/ruc/pasaporte
Future<String> getUserCed()async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('usuario_ced') ?? '';
}




