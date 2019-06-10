import 'package:azur/widgets/widgets_img_lib.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';


class FormularioCrearPublicacion extends StatefulWidget {
  final String title= 'Registro de usuario';

  @override
  _FormularioCrearPublicacionState createState() => new _FormularioCrearPublicacionState();
}


class _FormularioCrearPublicacionState extends State<FormularioCrearPublicacion> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  // Variables del formulario
  List<String> _tiposInmueble = <String>['','Casa', 'Oficina', 'Terreno'];
  String _nombreTipo = '';

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

  void _abrirExporadorArchivos() async{
    _rutasImagenes = null;
    _rutasImagenes = await FilePicker.getMultiFilePath(type: FileType.IMAGE );
    if (!mounted) return;
    setState(() {
      imagenesInmueble = _rutasImagenes.values.toList();
    });
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
        child: new ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
              construir_campo_tipo(),
              construir_campo_titulo(),
              construir_campo_predio(),
              construir_campo_ubicacion(),
              construir_campo_descripcion(),
              construir_campo_precio(),
              construir_campo_imagenes(),
              construir_navegador_archivos(),
              construir_boton_submit(),
          ],
        ),
      ),
    );
  }


  // Construye el campo para la descripcion
  Widget construir_campo_descripcion(){ // ignore: non_constant_identifier_names
    return new  TextFormField(
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
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        icon: const Icon(Icons.call_to_action),
        hintText: "Ingrese el predio del inmueble",
        labelText: "Predio",
      ),
      validator: (String valor){
        if(valor.isEmpty){
          return 'Por favor ingrese un predio';
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
      onSaved: (valor){
        setState(() {
            _tipoInmuebleId = _tiposInmueble.indexOf(valor);
            print("Tipo de inmueble es $_tipoInmuebleId");

        });
      },
      builder: (FormFieldState state){
        return InputDecorator(
          decoration: InputDecoration(
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

  Widget construir_campo_imagenes(){   // ignore: non_constant_identifier_names
    return new FormField(
      onSaved: (valor){
        setState(() {
          _rutasImg = imagenesInmueble;
          print("Rutas img del inmueble es $_rutasImg");

        });
      },
      builder: (FormFieldState state){
        return InputDecorator(
          decoration: InputDecoration(
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
            if (_formKey.currentState.validate()) {
              // Si es valido se mostrar un mensaje
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Procesando información..')));
              _formKey.currentState.save();
              // Llamar al servicio de registrar publicacion
            }
            // Redirigir a la pantalla de inicio
          },
        )
    );
  }

  Widget construir_navegador_archivos(){ // ignore: non_constant_identifier_names
    return new Container(
        child: new Column(
        children: <Widget>[
        new RaisedButton(
          onPressed: ()=>_abrirExporadorArchivos(),
              child: Text("Buscar imagenes"),
          ),
          imagenesInmueble!=null?new VisorImagenes(urls: imagenesInmueble,localStorage: true,):new Text("No hay imagenes"),
        ],
      ),
    );
  }
}