import 'package:azur/main.dart';
import 'package:azur/servicios/usuario.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Activacion extends StatefulWidget {
  @override
  _ActivacionState createState() => new _ActivacionState();
 }
class _ActivacionState extends State<Activacion> {
  
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _codigo = "";

  @override
  Widget build(BuildContext context) {
   return new Scaffold(
     appBar: new AppBar(title: new Text("Código de confirmación"),),
      body: new Container(
        child:new Center(
              child: new Form(
                key: _formKey,
                              autovalidate: true,

                child: new ListView(
                  children: <Widget>[
                    new TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.email),
                        hintText: 'Ingresa código de activacion',
                        labelText: 'código de activacion',
                      ),
                    validator: (value){
                      if(value.isEmpty){
                          return 'Por favor ingrese su código de activacion';
                      }
                    },
                    keyboardType: TextInputType.text,
                    onSaved: (valor){
                              setState(() {
                                _codigo = valor;
                              });
                            },
                    ),
                    new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        child: const Text('Enviar'),
                        onPressed: ()async{
                          //Llamar al servicio de verificar
                          // Si el formulario es valido
                          if (_formKey.currentState.validate()) {
                            // Si es valido se mostrar un mensaje
                            /*Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text('Procesando datos..')));*/
                            _formKey.currentState.save();    
                            // Llamar al servicio de login 
                            await validar(_codigo).then(
                              (resultado){
                                print(resultado);
                                if(resultado){
                                      //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Verificacion completa!!')));
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => AzurApp()));
                                }
                              }
                            ).catchError((error){print("El error: $error");});
                          // new usuario(_email,_password).login().then().catch() Metodo async
                      // Si es correcto ir a la siguiente pantalla
                      // Si no es correcto mostrar los errores        
                    }
                          // Redirigir a la pantalla de confirmacion
                        },
                      )
                    )
                  ],
                ),
              ) ,
            )
      ),
   );
  }
}