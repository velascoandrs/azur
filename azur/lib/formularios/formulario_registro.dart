import 'dart:ui';

import 'package:azur/pages/activacion.dart';
import 'package:azur/servicios/usuario.service.dart';
import 'package:azur/utilitarios/avisos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormularioRegistro extends StatefulWidget {
  final String title= 'Registro de usuario';

  @override
  _FormularioRegistroState createState() => new _FormularioRegistroState();
}

class _FormularioRegistroState extends State<FormularioRegistro> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  // Atributos del formulario
  List<String> _tipos = <String>['','NATURAL', 'JURIDICO', 'EXTRANJERA'];
  String _tipo = '';
  String _identificador = '';
  String _telefono = '';
  String _correo = '';
  String _password = '';
  List<String> _errores = [];
  int _tipoId = 0;
  bool existe_correo = false;
  bool formulario_habilitado = true;

  Future validarCorreoApi(String correo) async {
    var existe = await existeCorreo(correo);
    setState(() {
      existe_correo =  existe;
    });
  }

  Widget campoCedula(){
    return new TextFormField(
      enabled: formulario_habilitado,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Cedula',
                      labelText: 'número de cedula',
                    ),
                    maxLength: 10,
                    keyboardType: TextInputType.number,

                    validator: (value){
                      if(value.isEmpty){
                          return 'Por favor ingrese un número valido';
                      }
                    },
                    onSaved: (valor){
                      setState(() {
                        _identificador = valor;
                      });
                    },
                  );
  }

  Widget campoRuc(){
    return new TextFormField(
      enabled: formulario_habilitado,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'RUC',
                      labelText: 'número RUC',
                    ),
                    maxLength: 13,
                    keyboardType: TextInputType.number,

                    validator: (value){
                      if(value.isEmpty){
                          return 'Por favor ingrese un número valido';
                      }
                    },
                    onSaved: (valor){
                      setState(() {
                        _identificador = valor;
                      });
                    },
                  );
  }

  Widget campoPasaporte(){
    return new TextFormField(
      enabled: formulario_habilitado,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Pasaporte',
                      labelText: 'número de pasaporte',
                    ),
                    maxLength: 14,
                    keyboardType: TextInputType.number,

                    validator: (value){
                      if(value.isEmpty){
                          return 'Por favor ingrese un número valido';
                      }
                    },
                    onSaved: (valor){
                      setState(() {
                        _identificador = valor;
                      });
                    },
                  );
  }
  

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
          top: false,
          bottom: false,
          left:  true,
          right: true,
          child:  new Form( // Cuerpo del formulario
              key: _formKey,
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  
                  new TextFormField( // TextField para el telefono celular
                    enabled: formulario_habilitado,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.phone),
                      hintText: 'Ingresa un número de teléfono celular',
                      labelText: 'número',
                    ),
                    maxLength: 10,
                    validator: (value){ // fUN
                      if(value.isEmpty){
                          return 'Por favor ingrese un número de teléfono celular';
                      }
                    },
                    onSaved: (valor){
                              setState(() {
                                _telefono = valor;
                              });
                            },
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                  ),
                  new TextFormField(
                    enabled: formulario_habilitado,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.email),
                      hintText: 'Ingresa una dirección de correo electrónico',
                      labelText: 'correo electrónico',
                    ),
                    validator: (value){
                      if(value.isEmpty){
                          return 'Por favor ingrese un número de correo electrónico';
                      }
                      print("El valor de la valiacion $formulario_habilitado");
                      if(formulario_habilitado==true){
                        validarCorreoApi(value);
                        if(existe_correo){
                          return 'Ya existe un usuario con ese correo electronico';
                        }
                      }

                    },
                    keyboardType: TextInputType.emailAddress,

                    onSaved: (valor){
                              setState(() {
                                _correo = valor;
                              });
                            },
                  ),
                  new FormField(
                    enabled: formulario_habilitado,
                    onSaved: (valor){
                        setState(() {
                          _tipo = valor; 
                        });
                    },
                    builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.category),
                          labelText: 'Tipo',
                        ),
                        isEmpty: _tipo == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            value: _tipo,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                _tipo = newValue;
                                state.didChange(newValue);
                                _tipoId=_tipos.indexOf(newValue);
                                print(_tipoId);
                              });
                            },
                            items: _tipos.map((String value) {
                              return new DropdownMenuItem(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),_tipoId==1?campoCedula():_tipoId==2?campoRuc():_tipoId==3?campoPasaporte():new Container(),
                  new TextFormField(
                    enabled: formulario_habilitado,
                    obscureText: true,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.security),
                      hintText: 'Ingrese una contraseña',
                      labelText: 'contraseña',
                    
                    ),
                    validator: (value){
                      if(value.isEmpty){
                          return 'Por favor ingrese una contraseña';
                      }
                    },
                    onSaved: (valor){
                      setState(() {
                        _password = valor;
                      });
                    },
                  ),
                  new Container(
                    padding: const EdgeInsets.only(top: 50),
                    child:
                    new Material(
                        borderRadius: BorderRadius.circular(30.0),
                       color: Colors.black87,
                       elevation: 5,
                        child: new MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        child: const Text('Registrar'),
                        onPressed: ()async{
                          //Llamar al servicio de crear
                          // Si el formulario es valido
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              formulario_habilitado = false;
                            });
                            // Si es valido se mostrar un mensaje
                            Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text('Procesando datos..')));
                            _formKey.currentState.save();
                            // Llamar al servicio de login
                            await save(_correo,_password,_telefono,_identificador,_tipoId).then(
                              (resultado){
                                print(resultado['estado']);
                                if(resultado['estado']){
                                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Registrado!!')));
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Activacion()
                                          ),
                                          ModalRoute.withName("/Home")
                                      );
                                      //Navigator.push(context,MaterialPageRoute(builder: (context) => Activacion()),);

                                }else{
                                    setState(() {
                                      _errores = resultado['errores-list'];
                                      print(_errores);
                                    });

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
                    ),
    ),
                    new Container(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: _errores.length>0?Avisos(mensajes: _errores,):Container()
                    )

                ],
              )));
  }
}