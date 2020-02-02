class Usuario {
    int id;
    String cedulaRuc;
    String telefono;
    String email;
    String tipo;
    

    // Factory recibe el json desde el servicio y retorna una instancia del usuario
    factory Usuario(Map jsonMap){
        try{
            return new Usuario.deserializar(jsonMap);
        }catch(ex){
            throw ex;
        }
    }

    // Deserializar el usuario desde el json
     Usuario.deserializar(Map json):
      id = int.parse(json["id"]),
      cedulaRuc = json["cedulaRuc"],
      telefono = json["telefono"],
      email = json["email"],
      tipo = json["tipo"];
}
