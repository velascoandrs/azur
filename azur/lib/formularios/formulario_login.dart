import 'package:azur/home.dart';
import 'package:azur/pages/registro.usuario.dart';
import 'package:azur/servicios/usuario.service.dart';
import 'package:azur/utilitarios/session.dart';
import 'package:flutter/material.dart';

class FormularioLogin extends StatefulWidget {
  @override
  _FormularioLoginState createState() => new _FormularioLoginState();
 }


class _FormularioLoginState extends State<FormularioLogin> {

  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);


  @override
  Widget build(BuildContext context) {
   return new Form(
     key: _formKey,
     child: new ListView(
       children: <Widget>[
         SizedBox(
          height: 15,
          ), 
         SizedBox(
                      height: 200.0,
                      child: new Image.asset("assets/login.png"),

          ),
        SizedBox(
          height: 15,
        ),
         new TextFormField(
           decoration: InputDecoration(
              labelText: "Correo Electrónico",
              labelStyle: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
              hintText:'email',
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, style: BorderStyle.solid),borderRadius: BorderRadius.circular(32.0)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, style: BorderStyle.solid)),

               filled: true,
              fillColor: Colors.black38
             ),
           validator: (value){
             if(value.isEmpty){
               return 'Por favor ingrese un correo electrónico';
             }
           },
           onSaved: (value){
             setState(() {
               _email = value;
             });
           },
         ),
         SizedBox(
                      height: 15.0,
          ),
         new TextFormField(
           
           obscureText: true,
           decoration: InputDecoration(
                labelText: "Contraseña",
                labelStyle: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
                hintText:'contraseña',
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, style: BorderStyle.solid),borderRadius: BorderRadius.circular(32.0)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, style: BorderStyle.solid)),
                filled: true,
                fillColor: Colors.black38,

             ),
           validator: (value){
             if(value.isEmpty){
               return 'Por favor ingrese una contraseña valida';
             }
           },
           onSaved: (value){
             setState(() {
               _password = value;
             });
           },
         ),
         SizedBox(
                      height: 15.0,
          ),
         Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color:Colors.black87,
              child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () async{
                      // Si el formulario es valido
                      if (_formKey.currentState.validate()) {
                      // Si es valido se mostrar un mensaje
                      Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('Procesando datos..')));
                      _formKey.currentState.save();    
                      // Llamar al servicio de login 
                          await login(_email,_password).then(
                            (estato){
                                if(estato){
                                  getUserCed().then(
                                    (valor){
                                        Scaffold.of(context)
                                    .showSnackBar(SnackBar(content: Text('Bienvenido: $valor')));
                                    Navigator.push(context,MaterialPageRoute(builder: (context) => Home(usuario: valor,)),);
                                    }
                                  );
                                  
                                }else{
                                  Scaffold.of(context)
                                    .showSnackBar(SnackBar(content: Text('Credenciales invalidas')));
                                    //Navigator.push(context,MaterialPageRoute(builder: (context) => Home()),);
                                }
                             }
                          ).catchError((error){print("El error: $error");});
                          // new usuario(_email,_password).login().then().catch() Metodo async
                      // Si es correcto ir a la siguiente pantalla
                      // Si no es correcto mostrar los errores        
                    }
                  },
                  child: Text('Login',textAlign: TextAlign.center,style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold),),
                )
              
            ),
          
          new Divider(height: 20,color: Colors.black87,),
          Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.yellow[600],
              child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {
                      // Ir a pantalla registrar
                       Navigator.of(context, rootNavigator: true).pop();
                       Navigator.push(context,MaterialPageRoute(builder: (context) => Registro()),);
                  },
                  child: Text('Registrarse',textAlign: TextAlign.center,style: style.copyWith(color: Colors.black, fontWeight: FontWeight.bold),),
                )
              
            ),
       ],
     ),
   );
  }
}