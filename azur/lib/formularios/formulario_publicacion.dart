import 'package:azur/modelos/inmueble.model.dart';
import 'package:azur/servicios/publicacion.service.dart';
import 'package:azur/servicios/usuario.service.dart';
import 'package:azur/utilitarios/session.dart';
import 'package:azur/widgets/widgets_img_lib.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../home.dart';


class FormularioCrearPublicacion extends StatefulWidget {
  final String title= 'Registro de usuario';

  @override
  _FormularioCrearPublicacionState createState() => new _FormularioCrearPublicacionState();
}


class _FormularioCrearPublicacionState extends State<FormularioCrearPublicacion> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  // Variables del formulario
  List<String> _tiposInmueble = <String>['','Casa', 'Oficina', 'Departamento'];
  List<String> _sectores = <String>['','Norte', 'Centro', 'Sur', 'Centro-Norte'];
  String _nombreTipo = '';
  String _nombreSector = '';

  // Diccionarios de rutas
  Map<String, String> _rutasImagenes;
  // Lista de rutas
  List<String> imagenesInmueble;
  List<String> _rutasImg = [];

  int _predio;
  String _ubicacion = "";
  String _titulo = "";
  String _descripcion = "";
  double _precio = 0.00;
  int _tipoInmuebleId = 0;
  int _sectorId = 0;


  bool estaSubiendo = false;
  bool formularioHabilitado = true;
  bool _seGuardo = false;
  bool _existePredio = false;
  RegExp numeroRegex = RegExp(r'([1234567890]$)');


  Future validarExistePredio(String correo) async {
    var resultado = await InmuebleService().existePredio(correo);
    setState(() {
      _existePredio = resultado;
    });
  }

  void irInicio()async{
    var valor = await getUserCed();
    //Navigator.of(context).pop();
    //Navigator.push(context,MaterialPageRoute(builder: (context) => Home(usuario: valor,)),);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => Home(usuario: valor,)
        ),
        ModalRoute.withName("/Home")
    );
  }

  void _mostrarDialogo(String contenido, bool estado) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Aviso"),
          content: new Text(contenido),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Continuar"),
              onPressed: () async{

                if (estado){
                  irInicio();
                }
                setState(() {
                  estaSubiendo = false;
                  formularioHabilitado = true;
                });
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _abrirExporadorArchivos() async{
    _rutasImagenes = null;
    _rutasImagenes = await FilePicker.getMultiFilePath(type: FileType.IMAGE );
    if (!mounted) return;
    setState(() {
      imagenesInmueble = _rutasImagenes.values.toList();
    });
  }

  Widget vacio(){
    return SizedBox();
  }

  Widget animacionCargando(){
    return _seGuardo==true?exitoGuardar():Container(
      alignment: Alignment.center,
      height: 50,
      width: 50,
      child: new CircularProgressIndicator(),
    );
  }

  Widget exitoGuardar(){
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(const Radius.circular(15.0)),
        color: Colors.yellow[800],
      ),
      width: 300,
      height: 100,
      child: new Column(
        children: <Widget>[
          Text("Publicacion registrada!!!",style: TextStyle(fontSize: 20),),
          FlatButton(
            color: Colors.black87,
            child: Text("Ir a inicio"),
            onPressed: (){irInicio();},
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SafeArea(
      top: false,
      bottom: false,
      left: true,
      right: true,
      child: new Form(
        key: _formKey,
        autovalidate: true,
        child: _seGuardo?exitoGuardar():new ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
              construir_campo_tipo(),
              construir_campo_titulo(),
              construir_campo_sector(),
              construir_campo_predio(),
              construir_campo_ubicacion(),
              construir_campo_descripcion(),
              construir_campo_precio(),
              construir_campo_imagenes(),
              construir_navegador_archivos(),
              formularioHabilitado?construir_boton_submit():animacionCargando(),
          ],
        ),
      ),
    );
  }


  // Construye el campo para la descripcion
  Widget construir_campo_descripcion(){ // ignore: non_constant_identifier_names
    return new  TextFormField(
      enabled: formularioHabilitado,
      decoration: const InputDecoration(
        icon: const Icon(Icons.description),
        hintText: "Descripción del inmueble",
        labelText: "Descripción",
      ),
      maxLength: 180,
      validator: (String valor){
        if(valor.isEmpty){
          return 'Por favor ingrese una descripción';
        }
      },
      onSaved: (String valor){
        setState(() {
          _descripcion = valor;
          print("La descripción ingresada es $_descripcion");

        });
      },
    );
  }

  // Construye el campo para el numero de predio
  Widget construir_campo_predio(){ // ignore: non_constant_identifier_names
    return new  TextFormField(
      enabled: formularioHabilitado,
      keyboardType: TextInputType.numberWithOptions(decimal: false,signed: false),
      decoration: const InputDecoration(
        icon: const Icon(Icons.call_to_action),
        hintText: "Ingrese el predio del inmueble",
        labelText: "Predio",
      ),
      validator: (String valor){
        if(valor.isEmpty){
          return 'Por favor ingrese un predio';
        }
        if(!numeroRegex.hasMatch(valor)){
          return "Ingresa un numero entero";
        }
        validarExistePredio(valor);
        if(_existePredio){
            return "Ya existe un inmueble con ese predio";
        }
        // Llamar al servicio para consultar si el predio existe
      },
      onSaved: (valor){
        setState(() {
          _predio = int.parse(valor);
          print("El predio ingresado es $_predio");
        });
      },
    );
  }

  // Construye el campo para el numero de precio
  Widget construir_campo_precio(){ // ignore: non_constant_identifier_names
    return new  TextFormField(
      enabled: formularioHabilitado,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        icon: const Icon(Icons.attach_money),
        hintText: "Precio del inmueble",
        labelText: "Precio",
      ),
      validator: (String valor){
        if(valor.isEmpty){
          return 'Por favor ingrese un precio';
        }
        if(!numeroRegex.hasMatch(valor)){
          return "Ingresa un numero entero";
        }
        // Llamar al servicio para consultar si el predio existe
      },
      onSaved: (valor){
        setState(() {
          _precio = double.parse(valor);
          print("El precio ingresado es $_precio");
        });
      },
    );
  }

  // Construye el campo para el titulo
  Widget construir_campo_titulo(){ // ignore: non_constant_identifier_names
    return new  TextFormField(
      enabled: formularioHabilitado,
      decoration: const InputDecoration(
        icon: const Icon(Icons.text_fields),
        hintText: "Ingrese el título de la publicación",
        labelText: "Título",
      ),
      validator: (String valor){
        if(valor.isEmpty){
          return 'Por favor ingrese un título';
        }
      },
      onSaved: (String valor){
        setState(() {
          _titulo = valor;
          print("El titulo ingresado es $_titulo");

        });
      },
    );
  }

  // Construye el campo para la ubicacion
  Widget construir_campo_ubicacion(){ // ignore: non_constant_identifier_names
    return new  TextFormField(
      enabled: formularioHabilitado,
      decoration: const InputDecoration(
        icon: const Icon(Icons.map),
        hintText: "Ingrese la ubicación del inmueble",
        labelText: "Ubicación",
      ),
      maxLength: 80,
      validator: (String valor){
        if(valor.isEmpty){
          return 'Por favor ingrese una ubicación';
        }
      },
      onSaved: (String valor){
        setState(() {
          _ubicacion = valor;
          print("El ubicación ingresado es $_ubicacion");
        });
      },
    );
  }

  // Construye el campo para la ubicacion
  Widget construir_campo_tipo(){   // ignore: non_constant_identifier_names
    return new FormField(
      enabled: formularioHabilitado,
      onSaved: (valor){
        setState(() {
            _tipoInmuebleId = _tiposInmueble.indexOf(valor);
            print("Tipo de inmueble es $_tipoInmuebleId");

        });
      },
      builder: (FormFieldState state){
        return InputDecorator(
          decoration: InputDecoration(
            enabled: formularioHabilitado,
            icon: const Icon(Icons.category),
            labelText: 'Tipo de Inmueble',
          ),
          isEmpty: _nombreTipo == '',
          child: new DropdownButtonHideUnderline(
            child: new DropdownButton(
              value: _nombreTipo,
              isDense: true,
              onChanged: (String valor){
                setState(() {
                  print("El valor es $valor");
                  _nombreTipo = valor;
                  state.didChange(valor);
                });
              },
              items: _tiposInmueble.map((String valor){
                return new DropdownMenuItem(
                  value: valor,
                  child: new Text(valor),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }


  Widget construir_campo_sector(){   // ignore: non_constant_identifier_names
    return new FormField(
      enabled: formularioHabilitado,
      onSaved: (valor){
        setState(() {
          _sectorId = _sectores.indexOf(valor);
          print("El sector es $_sectorId");
        });
      },
      builder: (FormFieldState state){
        return InputDecorator(
          decoration: InputDecoration(
            enabled: formularioHabilitado,
            icon: const Icon(Icons.place),
            labelText: 'Sector',
          ),
          isEmpty: _nombreSector == '',
          child: new DropdownButtonHideUnderline(
            child: new DropdownButton(
              value: _nombreSector,
              isDense: true,
              onChanged: (String valor){
                setState(() {
                  print("El valor del sector es $valor");
                  _nombreSector = valor;
                  state.didChange(valor);
                });
              },
              items: _sectores.map((String valor){
                return new DropdownMenuItem(
                  value: valor,
                  child: new Text(valor),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget construir_campo_imagenes(){   // ignore: non_constant_identifier_names
    return new FormField(
      enabled: formularioHabilitado,
      onSaved: (valor){
        setState(() {
          _rutasImg = imagenesInmueble;
          print("Rutas img del inmueble es $_rutasImg");
          print("Size de la lista: ${imagenesInmueble.length}");

        });
      },
      builder: (FormFieldState state){
        return InputDecorator(
          decoration: InputDecoration(
            enabled: formularioHabilitado,
            icon: const Icon(Icons.image),
            labelText: 'Imagenes del inmueble',
            hintText: "Ingrese de 2 a 5 imagenes",
          ),
          isEmpty: imagenesInmueble == null || imagenesInmueble.length < 2 && imagenesInmueble.length > 5,
          child: null,

        );
      },
    );
  }

  // Construir boton de submit
  Widget construir_boton_submit(){  // ignore: non_constant_identifier_names
    return new Container(
        padding: const EdgeInsets.only(left: 40.0, top: 20.0),
        child: new MaterialButton(
          color: Colors.redAccent,
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          child: const Text('Publicar'),
          onPressed: ()async{
            //Llamar al servicio de crear
            // Si el formulario es valido
            var formularioValido = true;
            var erroresExtras = '';
            if (imagenesInmueble!=null && imagenesInmueble.length >=2 && imagenesInmueble.length <=5){
              setState(() {
                formularioValido = true;
              });
            }else{
              erroresExtras += "Debe subir entre 2 o 5 imagenes del inmueble\n";
              formularioValido = false;
            }
            if(_nombreTipo == ''){
              erroresExtras+="Seleccione un tipo de inmueble\n";
              formularioValido = false;
            }

            if(_nombreSector == ''){
              erroresExtras+="Seleccione un sector\n";
              formularioValido = false;
            }

            if (_formKey.currentState.validate() && formularioValido==true) {
              setState(() {
                estaSubiendo = true;
                formularioHabilitado  = false;
              });
              _formKey.currentState.save();
              // Llamar al servicio de registrar publicacion
              var seGuardo = await InmuebleService().crearInmueble(
                  _predio, _ubicacion, _rutasImg, _titulo,
                  _precio, _tipoInmuebleId, _descripcion, _sectorId);
              print("Se guardo: $seGuardo");
              if(seGuardo){
                     //_mostrarDialogo("Inmueble publicado con exito",true);
                     setState(() {
                       _seGuardo = true;
                     });
                      //irInicio();
              }else{
                    _mostrarDialogo("Ocurrio un problema intentelo más tarde",false);
                    setState(() {
                        estaSubiendo =false;
                    });
              }
            }else{
              _mostrarDialogo("Formulario invalido: \n$erroresExtras", false);
              setState(() {
                estaSubiendo =false;
              });
            }
          },
        )
    );
  }

  Widget construir_navegador_archivos(){ // ignore: non_constant_identifier_names
    return  new Container(
        child: new Column(
        children: <Widget>[
          formularioHabilitado?new RaisedButton(
          onPressed: ()=>_abrirExporadorArchivos(),
              child: Text("Buscar imagenes"),
          ):vacio(),
          imagenesInmueble!=null?new VisorImagenes(urls: imagenesInmueble,localStorage: true,):new Text("No hay imagenes"),
        ],
      ),
    );
  }
}