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
              hintText:'email',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
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
                labelText: "Password",
                hintText:'clave',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                

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
              color: Color(0xff01A0C7),
              child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {
                      // Si el formulario es valido
                      if (_formKey.currentState.validate()) {
                      // Si es valido se mostrar un mensaje
                      Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('Procesando datos..')));
                      _formKey.currentState.save();    
                      // Llamar al servicio de login 
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
              color: Colors.greenAccent,
              child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {
                      // Ir a pantalla registrar
                  },
                  child: Text('Registrarse',textAlign: TextAlign.center,style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold),),
                )
              
            ),
       ],
     ),
   );
  }
}