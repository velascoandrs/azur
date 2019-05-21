import 'package:azur/servicios/usuario.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormularioRegistro extends StatefulWidget {
  final String title= 'Registro de usuario';

  @override
  _FormularioRegistroState createState() => new _FormularioRegistroState();
}

class _FormularioRegistroState extends State<FormularioRegistro> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<String> _tipos = <String>['','NATURAL', 'JURIDICO', 'EXTRANJERA'];
  String _tipo = '';
  String _identificador = '';
  String _telefono = '';
  String _correo = '';
  String _password = '';
  int _tipoId = 0;

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.phone),
                      hintText: 'Ingresa un número de teléfono celular',
                      labelText: 'número',
                    ),
                    validator: (value){
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
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.email),
                      hintText: 'Ingresa una dirección de correo electrónico',
                      labelText: 'correo electrónico',
                    ),
                    validator: (value){
                      if(value.isEmpty){
                          return 'Por favor ingrese un número de correo electrónico';
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
                    onSaved: (valor){
                        setState(() {
                          _tipo = valor; 
                        });
                    },
                    builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.color_lens),
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
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Cedula/RUC/Pasaporte',
                      labelText: 'número de identificación',
                    ),
                    validator: (value){
                      if(value.isEmpty){
                          return 'Por favor ingrese un número de identificación';
                      }
                    },
                    onSaved: (valor){
                      setState(() {
                        _identificador = valor;
                      });
                    },
                  ),
                  new TextFormField(
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
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        child: const Text('Registrar'),
                        onPressed: ()async{
                          //Llamar al servicio de crear
                          // Si el formulario es valido
                          if (_formKey.currentState.validate()) {
                            // Si es valido se mostrar un mensaje
                            Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text('Procesando datos..')));
                            _formKey.currentState.save();    
                            // Llamar al servicio de login 
                            await save(_correo,_password,_telefono,_identificador,_tipoId).then(
                              (resultado){
                                if(resultado){
                                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Registrado!!')));
                                }
                              }
                            ).catchError((error){print("El error: $error");});
                          // new usuario(_email,_password).login().then().catch() Metodo async
                      // Si es correcto ir a la siguiente pantalla
                      // Si no es correcto mostrar los errores        
                    }
                          // Redirigir a la pantalla de confirmacion
                        },
                      )),
                ],
              )));
  }
}